Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12B4E6ECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 08:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbiCYHYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbiCYHYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:24:51 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F2324F0D;
        Fri, 25 Mar 2022 00:23:16 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P2H3gA021824;
        Fri, 25 Mar 2022 07:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=zCnI4DWazABJ/DiK0u64Wc7NWxTfnhOudIO/NQntJ8s=;
 b=NJ5parn+3/hBa0eEKQYqX230CexULbOb+2HAoyRq5jVkHV/FVxso1zDLiG2EKfSZ5kge
 pJ3RXKzJ+JeQzTwaO61bsYJAkD+nF9o76Haq8H8bwrBcDfZoCgP8D+DW8vTiKKsN8IYh
 xZuVeH0JaAe0nYrecNQ4F01n5YwgbfFHq4iMKXexb4SuzukTdfCHVyMDV/6IvAi4Q/l+
 hkVvUOi+y0b1eaf6LUaL5z4DT7JDT5fLHqDVqPHJxgtJh8n0CMzh+Og6uOwW+rb32kMz
 i9Nu8JAqLc52DHx7IE1U0Z0Bs7aJ7uuzVmQ8yVb1eOo5Q7ztxGgPvK4O3f8CziLcqltt pw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2047.outbound.protection.outlook.com [104.47.26.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f0ydngf99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 07:22:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5ON3HY1Io5aBAp3Oy1stQ9N/YhlQBCaDXuTkefixOsGdRP/Fr4xpNXR+GUPSuwyckvUhV3RUTwXLscq3n8EJfmFIp0KuKY/XyZk3uZ3jt27+YxviUxk+B2aiLkj3bM3xEtQ+w5eNRq6lF76wZXm+hYxJ+yDFtkUr8VVn26SqFxDMV9qnm7D1tFIqwdoKjeegl1M2wjTpmem+AqYFvMRpmTZ1iTzLokUucNLuwTQoUaDHBl+5dz0Bnl9dnKyv4zjCYUeRSrYaP1BEvkOFKokbC2BZmVg+PEDxOUJZATxFgTQTeegfKahyvlUTaY/a1TCFP+PjV1NTdQbz46qtIZHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCnI4DWazABJ/DiK0u64Wc7NWxTfnhOudIO/NQntJ8s=;
 b=ifQUhTU+haXFvh8dRnhBme3sc9/R2cNJg3D5456a6wKvuuDgohmP5/io+6m1jKWDe/x1D8CAZksMhc6YOQgDaeE7Ud4S7vLWbTyZEjcbKO3GRhRJLUiUrP0QrINRj34fykSudgEanhTLBiWgbMx0DwGKj0azZWzforXWGsDTeO91CobjHDuno5RXCCtoxB+9lHziL9xJVIDYoxBz1SRJVKPLOlAI42BELE/C2WzZXan+XPRRTWGfAr32E0fn9hVHMs0Cb5wY5Fiz9sFvNKGCMdC/4taGVG2MOL3crHsxZLLuYH6yBboCydAiGph2W1wKUVgBM35ANzq4HbfVGv1h5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TY2PR04MB3581.apcprd04.prod.outlook.com (2603:1096:404:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 25 Mar
 2022 07:22:54 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 07:22:54 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH] exfat: reduce block requests when zeroing a cluster
Thread-Index: Adg/8vGi1uwGLxPQRBCWtJcMeyhbsgAGPcMAAAJpGoA=
Date:   Fri, 25 Mar 2022 07:22:54 +0000
Message-ID: <HK2PR04MB38918AE14149045AE90A6400811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38915D9ABDC81F7D5463C4E4811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Yj1Xmr/3GTd41p/e@infradead.org>
In-Reply-To: <Yj1Xmr/3GTd41p/e@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dcd8fac9-e44d-40f0-6f60-08da0e30479d
x-ms-traffictypediagnostic: TY2PR04MB3581:EE_
x-microsoft-antispam-prvs: <TY2PR04MB35811C6EE2A72359DC01E596811A9@TY2PR04MB3581.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBrQmKY97WzpHb13kOLnP3GX8dCIUM+lbssiGl68fGed1ZJdZVNIBCu7Eo3BYizQwjr7eiR0BHCbuMam1tFBKM1hWeKvu2waAna+tkac/g1EEz7rOFClSV7QWkigNJG0Ejbz4Tk84VtK62wUM8U0v24BE4lBbRjXcvsbngQ+iVlTN2RV9zD0VDCPjA+kFd/K7TWoFjnUkyOpgPZXMtZ/Edo4oDfwMnFW4l0WWyXVdvRzszVS4Srmb6cDiWj5BPdYRQsGG9vk6Du9bAeugswwO0qyuCiVBzqYeM9kZ+KsI/Rzr/g3kfT9vO8/UcGRfJ1mZhjvZc7oYFf1/mPipaPT+XNgcM95eB1kNP47gRWzzPpkiJz6mQeSOw5e7okHLMah/qUVZEHqfH5ynsVPKsxLJ2+EW54MQDhF9GnqlOZEd65YH3ImQvDA9PAlUpeeCislU0ZiV9T5zrn5HvAgf/pOW8J6NwuEx0BKw10oCWlFnfbTtR8vLNbQqhhWE7+NEMPCeKiE2zg+j+5yW1WQxxF3XAC3W2V0MwtF8sIbmy4l0t/HmXUB18m4y64+S4W6WYZ0SjFkNmTwdAgELnEbCVsaJpn/Rls1QmTfMan9VniFmLzKnYLH1vtc0FZhWmgRqLMG4Uppnl0L5Rgg2dPRuGxeq82Yjwi91BHFSK4Z3WcayVy9xeO5S1yIr66SvX6fVyyXdKeBv7n73q05or/Dxh5FoA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(107886003)(26005)(186003)(4326008)(64756008)(66446008)(66556008)(66946007)(6916009)(55016003)(122000001)(54906003)(316002)(76116006)(71200400001)(4744005)(33656002)(9686003)(66476007)(38070700005)(8676002)(6506007)(7696005)(5660300002)(38100700002)(83380400001)(508600001)(86362001)(8936002)(52536014)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S015RUdyZTRJSWpSVlJXaFdpRktxRDBpU2dHZFplN0hwc09UeDIwaGJVQVlh?=
 =?utf-8?B?VTZ0ZVYxQWE2YXdBMXluNnRwdkFNaU5oazFjQWlpVFNXQTVGV0ZqdUdZWVk3?=
 =?utf-8?B?ZVBjb01zZnh6OFJYeWpBMmRzZ0NKUDFwT0NkWDRxMkp0YnhvMyttZlVlblpv?=
 =?utf-8?B?eUFwRGVnaW5EMSsyQjdyY0E3VkVleU14VmpwOVJmc3J3Q1p3WkhPWHFEcFFp?=
 =?utf-8?B?cGo1SWo0T1lQblB5c3Z0eFZHeXNyVFpJZzlieXpvUmFPTE1lK3FubTB3eUtV?=
 =?utf-8?B?ZmdpK2JyWjJYMmVhcGdsQU5GNWtaL2pDNlJoWTFPSk9mS0hhNHkybHRsazJX?=
 =?utf-8?B?VUdmcVU2S0wxUVNuL3pmaUNHbG9yZ1FrWVVaVjl0bHREU1g1QkxmRHkxL3ZP?=
 =?utf-8?B?K0JnYi90dXZsYjRrdmcyNVlPRjNQVlpvU1RhdXcrUjhuWlRlMk9vNWVrZlZD?=
 =?utf-8?B?dytuU1VnL0hjeGJEanVpZW5FWkZPWWNIdzB5dVVueFY4S2pIK2k3UmZ1RTNO?=
 =?utf-8?B?NDZBYnZqc3gvSkYwdTl6NERsQit1RERKaVNjV0JyNjJ5dXVKYmxQb0wwK0tR?=
 =?utf-8?B?Zzd1NUVGS0JkNElxWENnQU81VmJDQXhXNHJHUnVpVVlqM2k1WEQ1VUFVLzE4?=
 =?utf-8?B?cWJINVdLTzh1U29OWVlSajU4K2x5cXZDY3VwUUxFNzh5YVdYZlhEcHZXM3Ev?=
 =?utf-8?B?NzE2QkExSHVidGM3YTk3MGNFZHV0c3FzcElDVFY2NWF3VmxFYnB5Mnlxaktk?=
 =?utf-8?B?ZithbVpHd2dOdEY2TkNWRWVqYTNmVXo5c2dvQTI3OExqcEtwYTFTeFIyMXlB?=
 =?utf-8?B?SEIwRDJzcEdUQnpqdzQ0dTBTSGk5bHRRT1V4Q0twV1Y3VWZNenRGQWp1ZnEr?=
 =?utf-8?B?RGlyaFVZU1dHVmIwMzYxaTBRaFhDZmhqZ2I3bWw2a2N6STNiaVJwcXgyRGtN?=
 =?utf-8?B?bmhPVjlvR3NuY0x6eHRONHNOdTRYWnorQ2htL3JEM3dEMUMweWEwL3VXRnRq?=
 =?utf-8?B?VnY2NXNYUTJ0WW15NmhmbVB4TVNFcWFIU0c3WXRsTTluemV6UXlNTk9RekNL?=
 =?utf-8?B?U0VBZklOT1plMWZzZUp2RUVka0JQY0dleW5Sa3VYalJrejVPc2d3RTVqYWJC?=
 =?utf-8?B?czl6ZWlVSlVlUGdKREZEb0kyd1VWb2NSQkczdTVNbklTL2wxYkFkaHM0c2Nl?=
 =?utf-8?B?ZkFGQ1Nqb2xUUkk3SGRqckpHT1phMnpYaFRaWmFBZWF6aThIcFFZOVMrZkFy?=
 =?utf-8?B?ZVdib0dJZjg0TlBZVGd5OWdwL0xxTjl1WkdCd2lNa0RQckhZSGM1Ulkxd3Fi?=
 =?utf-8?B?cUl5dEpidmhJVWczV0VFemZqZXNYVVpzYTdYMVV1SEZlQnhTeTA0SWUyTWVY?=
 =?utf-8?B?MmhJUDE3UVZ6NDRrL0hyanQraVFsS2w2K3VEYmxBVkl1Qlk3MVRsdHljWDVC?=
 =?utf-8?B?eERqN0NFQ1hpZGZxQWNSbmhmTG9uR3crS2FWNEJvRkRKd0lHTGlrWjZlK1Ux?=
 =?utf-8?B?a0JwNFVuWmZ2bDROdGxoR1lCVFcrK1huSFNHTVpFWUNqQ2VXNXVIQkc3eEI0?=
 =?utf-8?B?dkpTRDdPN1BIeW1FMlJ1QUdqYnpzdSt0cEQwYlAyUi9Td2d2N1drVWdQeG5y?=
 =?utf-8?B?b000ejNDNU1vaXk3Mlhmc1FtamllUlZQOTY3NUVnZXcwUS9TWUppZWhZM0hV?=
 =?utf-8?B?eWZRTWZRdTk3RjBqU3hORHFNUnJYWFVNNVFJTnp4cndvVDBoM1VrbVlVTGFt?=
 =?utf-8?B?SlV2MHhGV2I2YzZ2R3orZ2Rqa2YyRUt2Mzh3dThZUktCVUhLQnZxSEprQldp?=
 =?utf-8?B?ZTU5aHppS3lCQVNzVklsTXA3L0xBbmg3d0M4czVQck5ncXRxMURRcnZINGNu?=
 =?utf-8?B?VDJvVS9MWXE0b2xEMEQ4UUdBR1VrS3k5YUlEVnlMb1paVkRSaGZidjJWRmkz?=
 =?utf-8?B?ZC9JMDNURHB3RmlJdkJZajVHeWJzcUw4RFlaWmkrMFdVbjdkMWpyRUQvV282?=
 =?utf-8?B?cDlmOElkald3MEF4SjNqN1JORGNxTi9CK1ozY1VZZzg5MGNsN2x1L2VZVGdp?=
 =?utf-8?B?YTI0Rk95bWlTRkFuYkZObHdCb2VpT1JsVXloZXd4RGhYcVdvcTgyaXc1elUy?=
 =?utf-8?B?d0ZUb25iTEpkVE40UGErNEJrcjJrVTBkelBGM3FQcXB4V0NvYjFNSzdTMTBU?=
 =?utf-8?B?OWpGaEtjbS9XQ0NiWEFWSUlqWU1Ib25qQTZ1MlBjSmMxNWF1Q3ZCUHVvQ21Y?=
 =?utf-8?B?eS9IZDFqeUVMOFEvdVpwK0txaHZvbWlPOVEySW5JZFBkQnZqaVI1ODI4eGVZ?=
 =?utf-8?B?SEdQMDAraVlkQTV3NEhQR2thN3lRNTQ2OE5oWmNtSEZCZEFOLzhkQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd8fac9-e44d-40f0-6f60-08da0e30479d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 07:22:54.8440
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZFt+/s6WirNGiHGJtph1b9s9kC0xxCFDkNZIA1uDUN+apl0O3z2EbkyddS4ygwAjK1elesH5JeValOcYZwzFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR04MB3581
X-Proofpoint-GUID: UEXpGHIHTsRkm0i8ba3MfHyV7NcFq7Ft
X-Proofpoint-ORIG-GUID: UEXpGHIHTsRkm0i8ba3MfHyV7NcFq7Ft
X-Sony-Outbound-GUID: UEXpGHIHTsRkm0i8ba3MfHyV7NcFq7Ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1011
 phishscore=0 mlxlogscore=899 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203250039
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgQ2hyaXN0b3BoIEhlbGx3aWcsDQoNClRoYW5rIHlvdSBmb3IgeW91ciBjb21tZW50Lg0KDQo+
IE9uIEZyaSwgTWFyIDI1LCAyMDIyIGF0IDAzOjAwOjU1QU0gKzAwMDAsIFl1ZXpoYW5nLk1vQHNv
bnkuY29tIHdyb3RlOg0KPiA+ICsjaW5jbHVkZSA8bGludXgvYmxrX3R5cGVzLmg+DQo+IA0KPiBi
bGtfdHlwZXMuaCBpcyBub3QgYSBoZWFkZXIgZm9yIHB1YmxpYyB1c2UuICBXaGF0IGRvIHlvdSB3
YW50IGl0IGZvcj8NCg0KKwlzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZyA9IHNiLT5zX2Jk
ZXYtPmJkX2lub2RlLT5pX21hcHBpbmc7DQoNClRoZSB0eXBlIG9mICdzYi0+c19iZGV2JyBpcyAn
c3RydWN0IGJsb2NrX2RldmljZScuDQpJIHdhbnQgdG8gaW5jbHVkZSB0aGUgZGVmaW5pdGlvbiBv
ZiAnc3RydWN0IGJsb2NrX2RldmljZScoJ3N0cnVjdCBibG9ja19kZXZpY2UnIGlzIGRlZmluZWQg
aW4gPGxpbnV4L2Jsa190eXBlcy5oPikuDQoNClNob3VsZCBJIGNoYW5nZSB0byBpbmNsdWRlIDxs
aW51eC9ibGtkZXYuaD4/DQoNCkJlc3QgUmVnYXJkcywNCll1ZXpoYW5nIE1vDQo=
