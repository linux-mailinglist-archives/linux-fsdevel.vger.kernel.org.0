Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855984D4024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 05:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239285AbiCJEJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 23:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCJEJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 23:09:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E4C107AB4;
        Wed,  9 Mar 2022 20:08:38 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22A1N1xd022212;
        Thu, 10 Mar 2022 04:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V1ZdEeGRtWC3+Tpjy+1penCBtCNPKa6lH6R+gqx+t1I=;
 b=IkGIm7E1CMffZNVIMvwpnUNU4RtuC3IQL/85oeAXYVPamOK4Cw+i/JTBKhlPQxDwKjNe
 /h7RsuI1b3zlRC5hBGepFpy6uZkMdDwVWsFOfuSnR/7HhxJ/9ru9/4odWYEmE9iiFsOq
 NpzNsOvHeTlN1lSdJtVchSOWyMTKW8Gj5Gr0AA9C7My8RS1Yt3uVEfxS/ikNqQlnRJ3S
 IyeyWquAfEmyAAXOZKNgwrd0AN00n7Se2RRLrzPgn0R1nv6Rs5v4g0AOKn7IzHt+q63w
 zKw7kN6/LFqIF0fHrexBpTYzN8bR05xf/thWoZa4W3Zz6uR7LK9uzcNmyALCKvGkHcrP aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0v00y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:08:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22A41SOL192567;
        Thu, 10 Mar 2022 04:08:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3020.oracle.com with ESMTP id 3ekyp3auqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Mar 2022 04:08:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUaFObuiIeGXrlIh0wThzoCZuf93rYCoEG9wYDQr5ArRJAzWaCvUO/73Lnu8VuZKuI9gDxdv1Csz2RnpLAam0tqPvE0IbDG+DxDspXHArSWMrhewd3PMUW9lKz7aYQj7Mk6lqipP/1i4z852k7V0LtFNiZQnm0ujD1tgG4bgSv7Y49OLof4MQWZXLoX9lUkGOhyxoWPmT0u9zW7V43uv/IWkRAihOgIye/OPXtsaFwD+XOUZ6idDpSyK+oFb7g7Mkkwm8qthPByd12ccsvvn0zMgMoUqO9jz2hZB//EqH3b6hQcmY04tRKZ8N5qAOn8Xw+R++YDjr8Kko3kiInXPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1ZdEeGRtWC3+Tpjy+1penCBtCNPKa6lH6R+gqx+t1I=;
 b=kQkwz0B+TtXFtdH0gIXNRNFSyCfSs+TQEaj4slCjQ44MIEmWmY7770qyqPJlvlXcIc5d+vmySBeVvEwaJRM6l2qswaRwml3wFTe6i5aeJMVoeNfzdlLXg72/Vq3wrYf48dK34LlXMvXZ7A+YSkeg7vtOC8M/AkLmc5udsvVZ8lzbX0at8w1Apd750TlvLrJ7J6FxYLAUPQ2AMWxtU0XniUcOxhUdzqHxo3+pi1YqxYPEyct0/GXkR6cjC2tYv9o1KY6jjFXPWgcpyHGS1mTDdR2EGzQxl+BPBy7foQjg31xm3DGcCy7B2CgCkhSBW4PQS4QqNm/6etUm/mKXcVSVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1ZdEeGRtWC3+Tpjy+1penCBtCNPKa6lH6R+gqx+t1I=;
 b=AuW1bxNTZciC/3XsjIe4VsF600Dqphy9y/lxuExPcOYctO0JIhD2NpdfJIpwUdua/m/C7VlzFImEw/o9aeG5MHES/DNBY/2qPJ9JkgtUhj6tG19JEPHs/sx5fMtkvBAXYWHGSJVS3RIYQnzNkhZdiifvrW5y5N5ymb5uv4vqgaw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN0PR10MB5501.namprd10.prod.outlook.com (2603:10b6:408:148::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 04:08:30 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 04:08:30 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Jeff Layton <jlayton@redhat.com>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Thread-Topic: [PATCH RFC v15 01/11] fs/lock: add helper locks_any_blockers to
 check for blockers
Thread-Index: AQHYMCku2gD55cSpGkGygsBMZ14sZqy3kACAgABouoCAAA/zjQ==
Date:   Thu, 10 Mar 2022 04:08:30 +0000
Message-ID: <2E15A255-7A0A-4827-987A-E3B4A6A9E590@oracle.com>
References: <1646440633-3542-1-git-send-email-dai.ngo@oracle.com>
 <1646440633-3542-2-git-send-email-dai.ngo@oracle.com>
 <AB3847D1-CAD5-4D6F-8D49-C380F2E7AB64@oracle.com>
 <cf55f250-a1ba-243c-f826-3cbd91088d6b@oracle.com>
In-Reply-To: <cf55f250-a1ba-243c-f826-3cbd91088d6b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc06954f-04b8-4a30-cf7a-08da024ba2bf
x-ms-traffictypediagnostic: BN0PR10MB5501:EE_
x-microsoft-antispam-prvs: <BN0PR10MB550177C9AD0CE6D77FE93A73930B9@BN0PR10MB5501.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvhVb2CAhp6rb8s71lIBBhDIfZbwG0xx/9+fhZbjqSDsI8dabbQZhIOM9Pxinfprg+dRazFt5qW4k7J/NWgwDMnFL9gQVURakVkxpDyfLyX7TScXousPSXm5CMwscOTPkV7QAkiWPImBeHzBitZWZMBiIl3V4f9H6QNTGYpA92VQrGIBaOVa82hmqkw63oGlRnl/w4au0XHXFg6bjsR3LZ76D1Yt8NNT5ozL5ZokXCKEMBGNa2UUowJ86oZTa2teletJFOoN8ymBrmMTf/3723pMwPt8CzLWQYuy/qPH7kyYWmDvjFoxOrcDf8clmOMGw2n7MgVKtwpL7cETXNHfkl+T1W5mBfFBI5G8NhXX2b3glaOTjxBJLjbTcjo24zFAn7Ju+1SWh9gbzTVujC5YJv9KJsdwGIeNzTZnCsVLALqwcHJ8CYQrhmlv1kOURoxs9Wa4oLZZgfWpMgYH7acV1E7ykt6V+Qf3BWJ/oZqP7g7oZklVRWuo068Y+gI/iIoyA9Dja2XUP/FYdQQj3ZQRfvKyBs7u3S+huvTKwhp/aXkgIGIQkG5hyY7KGkxbUcxkoJ/OlEkq3Igx4uLisp3jaGT2dWwuCsvk6j5cuwvlM96FqAUboZ0/7TEt/OKuQOToL1wo+oOb6LqZ6XYaDLWn+g7ptILk0q2RX/e/HhRAWz6WAwg5ZM4eLCEp6BDeiOH1So25CpzMq5eAUJXRk0u46mbS8SmWGZ1G6CXjQopAx060qyIjxkktNbC5trdbp9X5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(4326008)(6862004)(83380400001)(38070700005)(86362001)(66446008)(91956017)(66946007)(36756003)(64756008)(76116006)(37006003)(5660300002)(316002)(66556008)(54906003)(8676002)(6636002)(6486002)(33656002)(6512007)(6506007)(2616005)(53546011)(186003)(26005)(38100700002)(122000001)(71200400001)(508600001)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk1md3pkZVBEUnZ1am1OenVsdCtmNkpDL2IwU0JXcUNaTHozbHpiaHcxMjFj?=
 =?utf-8?B?b055Q3BLTHJic2hPTDNjMFM3OC9ETXBMTnV3ZXd1QVRYcVN3d0NFTy80YUYz?=
 =?utf-8?B?Vmp2ODlwNUYwa0cxUGdqRkVQaDJhWTlFRzNHOElUeHBGTWwzQjVDN2VHSG8y?=
 =?utf-8?B?Nmd2REhKT1FTK1BnWS9GVjV2UFBCcUwrOFFOVjVaV0FFSGVFQ1FHbnNZN0Fq?=
 =?utf-8?B?VzRHRFVkQnM2UDBwdGJyenUrOFRNVlRQNlNHYktEditZeW5HZ0p5ZVZGMkda?=
 =?utf-8?B?YmxMK1RvUzVvbWp4QWJ3b0pnTFVsUk1QVlNLUHJRZVkzMXpPSXFjb3RvQjJa?=
 =?utf-8?B?ZlgvcWpCT284SU5mZ1o4UFVvdlFFclVJY1Q3UFVUdXJQNHpERjk0bER2RExP?=
 =?utf-8?B?b0V6eHJKRGlPRkdKQ081ZTQ3ZzNra0pUcG9XNldRWFRYUFdGSWdtQnF6V0g2?=
 =?utf-8?B?UG81bHNYZS8rZmpBUFNqN2ZEeUlOM21nejgwTjdsMUF2TnAvRHlJWXBWa29v?=
 =?utf-8?B?bU1VUm1aVDczUkg5OU52YUc5NlVjU1U1RkI2KzhvQmJHSkFTMWZrd0NsV1dT?=
 =?utf-8?B?WXNSeHpxRVZGNksvNVoyTkJlMjBBV2IvcHFTRUx0SG5QM3BQbGRNWml3WWRq?=
 =?utf-8?B?SVBpcjdnak1wWW04Y3A4TThidWlhTXVZV05Ncnp6QzNZRHhZOHB5OEdDaEVJ?=
 =?utf-8?B?SFpRY3p0aklFbHZhRXpkMVJoeEM4bVowcDZpUjg2SVZuUTFSbEoybnBYVlIy?=
 =?utf-8?B?cFpqd2w2THZ6UVp6dkNTS2kvRFYrM2hhTlFYNVkvZDF5anpLSkxYMVl3cXRJ?=
 =?utf-8?B?czdxbW5JYXR0VTJMT2VVUENQbmE3QlgwTjI2SDMrY0dQVFhlV0NrS0Z6ejFR?=
 =?utf-8?B?WFFTY1NuNUNrejArL053dnZZMmI1V1RFaEpPTFlYQkQ5MndCMVBzUzJTWCsz?=
 =?utf-8?B?UkVKaldqNkE3NVFDNUNjV25PZ0RaaC9qWVA0K0NJdk4zNmlxemhNc01ta3E4?=
 =?utf-8?B?eWJ1MCt1Y1YvSGpMWHNmQXpTdjY4a09ZVUpCT0h1ZnVDRzdaaEplTExYQ1F5?=
 =?utf-8?B?cTlDRGFoQjFGeU5ZaXUrVW5SMUdlUXVjeG5QU0hXNmc0OEpiR01xN2lTVlcz?=
 =?utf-8?B?OEthbVBLWUlmRzByYVRkVXFGZDRwT284VnpoLzZPUUI0bmd5Qm5Mcm9scHBC?=
 =?utf-8?B?YnlmcSs2QjNYOStaRlZaV3VWZ0RqL1FCK3BldE9Jd2YxZlFKdXBwSjdrdnpV?=
 =?utf-8?B?dGpkbW81U2s2M0w2ZkhVT3E0M1djZmtnZzhOekR0ZldpSWZrOXVjdWZZd3VR?=
 =?utf-8?B?QlZwb2hWNG4rbUZ5ZFVCOEgvako0S2dlR0dDTmloM1dGRnRJNXM4UTZHTmFU?=
 =?utf-8?B?aEQwMEFDb0djaUo5ZytyL2F6TXpSQnlnOWUreXRTNCtJc2o5dDJpWnFGREow?=
 =?utf-8?B?cGJZMGxzdDlhcytNdHJJT2x6b25VbCtOYW9MNlVrVjkyckh6eEwyd21IdGNq?=
 =?utf-8?B?Z0JhdnVSQU8wb011cVQ0c2hVNkh2MUp5UGRPZUZ6eTdiMzF5ejg2SHcwVHJv?=
 =?utf-8?B?NVQ1RkdsMHdxVlB2S1Fpd3BvT1lubzBpK3d1ZlRmc1E2OGJ3VGlPLzE3V3FT?=
 =?utf-8?B?TDhmY1VJQ2tiN2NLdUZwU3ZIRjUrMXlKWFprZjJEd2xKOGNnOVFhVW43YkxT?=
 =?utf-8?B?MUVrVHVmazhGZ0UzTHQzTEMrcCtJd25rTUdMaXZ5bDNoMlVBQTZPeWlmLzlJ?=
 =?utf-8?B?eHlNc2JZQWZoYlRCRnFZY3drSjlqWEtzZTlEU3VTYVVWUDUyUDlyc0RzM0VC?=
 =?utf-8?B?dEs0dXVqWjBvdmZTbE5ub21GbndFVktVM042NkpqWjh5RTBZM1ppRWZkMVRI?=
 =?utf-8?B?V2hnZjNIWmdvTHdCN3MydFprdFBUeDJsZE1vMGMyTXRDWlNINExQTmtiNXZq?=
 =?utf-8?B?T0kwYjVjUytCRDM2VytzZWYzVndCbkN2SjRMZEovd0wwci8vQ2p0Y2k3ckpU?=
 =?utf-8?B?SFV6R3VJMVdrdE5JL1VWOG5GOEw1Rmh4TndSdVU3c3RvclZLNkNpRnozaXl1?=
 =?utf-8?B?cWhyNlRvZEtpMEpBZmRXT1VYNE9pZytmUjVPcWhtUmUyWnlwOEc0ZmdtWEpu?=
 =?utf-8?B?OEYvOHRtOUtiWW9SVEJ1T0tUbzQ4OUlMbXJHSkFQQXI2ZDNndlF0Q0krKzJ5?=
 =?utf-8?Q?TNLUue277Z0LfyRMIf1TUg0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc06954f-04b8-4a30-cf7a-08da024ba2bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 04:08:30.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nngaAbxRENXBLwVwHG353L2FKVvdSJkbIa4H2K/v8zFtmr3oaoAb+O9C8hn5dVOBoW5P1tdDr12cx6Z+ynweCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5501
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203100019
X-Proofpoint-ORIG-GUID: _e1i4uMau9J2QdSLiQWBL2JIJur3gvVC
X-Proofpoint-GUID: _e1i4uMau9J2QdSLiQWBL2JIJur3gvVC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE1hciA5LCAyMDIyLCBhdCAxMDoxMSBQTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUu
Y29tPiB3cm90ZToNCj4gDQo+IO+7v09uIDMvOS8yMiAxMjo1NiBQTSwgQ2h1Y2sgTGV2ZXIgSUlJ
IHdyb3RlOg0KPj4gDQo+Pj4+IE9uIE1hciA0LCAyMDIyLCBhdCA3OjM3IFBNLCBEYWkgTmdvIDxk
YWkubmdvQG9yYWNsZS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IEFkZCBoZWxwZXIgbG9ja3NfYW55
X2Jsb2NrZXJzIHRvIGNoZWNrIGlmIHRoZXJlIGlzIGFueSBibG9ja2Vycw0KPj4+IGZvciBhIGZp
bGVfbG9jay4NCj4+PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBEYWkgTmdvIDxkYWkubmdvQG9yYWNs
ZS5jb20+DQo+Pj4gLS0tDQo+Pj4gaW5jbHVkZS9saW51eC9mcy5oIHwgMTAgKysrKysrKysrKw0K
Pj4+IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPj4+IGluZGV4IDgz
MWIyMDQzMGQ2ZS4uN2Y1NzU2YmZjYzEzIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvbGludXgv
ZnMuaA0KPj4+ICsrKyBiL2luY2x1ZGUvbGludXgvZnMuaA0KPj4+IEBAIC0xMjAwLDYgKzEyMDAs
MTEgQEAgZXh0ZXJuIHZvaWQgbGVhc2VfdW5yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZp
ZXJfYmxvY2sgKik7DQo+Pj4gc3RydWN0IGZpbGVzX3N0cnVjdDsNCj4+PiBleHRlcm4gdm9pZCBz
aG93X2ZkX2xvY2tzKHN0cnVjdCBzZXFfZmlsZSAqZiwNCj4+PiAgICAgICAgICAgICBzdHJ1Y3Qg
ZmlsZSAqZmlscCwgc3RydWN0IGZpbGVzX3N0cnVjdCAqZmlsZXMpOw0KPj4+ICsNCj4+PiArc3Rh
dGljIGlubGluZSBib29sIGxvY2tzX2hhc19ibG9ja2Vyc19sb2NrZWQoc3RydWN0IGZpbGVfbG9j
ayAqbGNrKQ0KPj4+ICt7DQo+Pj4gKyAgICByZXR1cm4gIWxpc3RfZW1wdHkoJmxjay0+ZmxfYmxv
Y2tlZF9yZXF1ZXN0cyk7DQo+Pj4gK30NCj4+PiAjZWxzZSAvKiAhQ09ORklHX0ZJTEVfTE9DS0lO
RyAqLw0KPj4+IHN0YXRpYyBpbmxpbmUgaW50IGZjbnRsX2dldGxrKHN0cnVjdCBmaWxlICpmaWxl
LCB1bnNpZ25lZCBpbnQgY21kLA0KPj4+ICAgICAgICAgICAgICAgICAgc3RydWN0IGZsb2NrIF9f
dXNlciAqdXNlcikNCj4+PiBAQCAtMTMzNSw2ICsxMzQwLDExIEBAIHN0YXRpYyBpbmxpbmUgaW50
IGxlYXNlX21vZGlmeShzdHJ1Y3QgZmlsZV9sb2NrICpmbCwgaW50IGFyZywNCj4+PiBzdHJ1Y3Qg
ZmlsZXNfc3RydWN0Ow0KPj4+IHN0YXRpYyBpbmxpbmUgdm9pZCBzaG93X2ZkX2xvY2tzKHN0cnVj
dCBzZXFfZmlsZSAqZiwNCj4+PiAgICAgICAgICAgIHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qg
ZmlsZXNfc3RydWN0ICpmaWxlcykge30NCj4+PiArDQo+Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBs
b2Nrc19oYXNfYmxvY2tlcnNfbG9ja2VkKHN0cnVjdCBmaWxlX2xvY2sgKmxjaykNCj4+PiArew0K
Pj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4+ICt9DQo+Pj4gI2VuZGlmIC8qICFDT05GSUdfRklM
RV9MT0NLSU5HICovDQo+Pj4gDQo+Pj4gc3RhdGljIGlubGluZSBzdHJ1Y3QgaW5vZGUgKmZpbGVf
aW5vZGUoY29uc3Qgc3RydWN0IGZpbGUgKmYpDQo+PiBIbS4gVGhpcyBpcyBub3QgZXhhY3RseSB3
aGF0IEkgaGFkIGluIG1pbmQuDQo+PiANCj4+IEluIG9yZGVyIHRvIGJlIG1vcmUga0FCSSBmcmll
bmRseSwgZmxfYmxvY2tlZF9yZXF1ZXN0cyBzaG91bGQgYmUNCj4+IGRlcmVmZXJlbmNlZCBvbmx5
IGluIGZzL2xvY2tzLmMuIElNTyB5b3Ugd2FudCB0byB0YWtlIHRoZSBpbm5lcg0KPj4gbG9vcCBp
biBuZnM0X2xvY2tvd25lcl9oYXNfYmxvY2tlcnMoKSBhbmQgbWFrZSB0aGF0IGEgZnVuY3Rpb24N
Cj4+IHRoYXQgbGl2ZXMgaW4gZnMvbG9ja3MuYy4gU29tZXRoaW5nIGFraW4gdG86DQo+PiANCj4+
IGZzL2xvY2tzLmM6DQo+PiANCj4+IC8qKg0KPj4gICogbG9ja3Nfb3duZXJfaGFzX2Jsb2NrZXJz
IC0gQ2hlY2sgZm9yIGJsb2NraW5nIGxvY2sgcmVxdWVzdHMNCj4+ICAqIEBmbGN0eDogZmlsZSBs
b2NrIGNvbnRleHQNCj4+ICAqIEBvd25lcjogbG9jayBvd25lcg0KPj4gICoNCj4+ICAqIFJldHVy
biB2YWx1ZXM6DQo+PiAgKiAgICV0cnVlOiBAY3R4IGhhcyBhdCBsZWFzdCBvbmUgYmxvY2tlcg0K
Pj4gICogICAlZmFsc2U6IEBjdHggaGFzIG5vIGJsb2NrZXJzDQo+PiAgKi8NCj4+IGJvb2wgbG9j
a3Nfb3duZXJfaGFzX2Jsb2NrZXJzKHN0cnVjdCBmaWxlX2xvY2tfY29udGV4dCAqZmxjdHgsDQo+
PiAgICAgICAgICAgICAgICAgIGZsX293bmVyX3Qgb3duZXIpDQo+PiB7DQo+PiAgICBzdHJ1Y3Qg
ZmlsZV9sb2NrICpmbDsNCj4+IA0KPj4gICAgc3Bpbl9sb2NrKCZmbGN0eC0+ZmxjX2xvY2spOw0K
Pj4gICAgbGlzdF9mb3JfZWFjaF9lbnRyeShmbCwgJmZsY3R4LT5mbGNfcG9zaXgsIGZsX2xpc3Qp
IHsNCj4+ICAgICAgICBpZiAoZmwtPmZsX293bmVyICE9IG93bmVyKQ0KPj4gICAgICAgICAgICBj
b250aW51ZTsNCj4+ICAgICAgICBpZiAoIWxpc3RfZW1wdHkoJmZsLT5mbF9ibG9ja2VkX3JlcXVl
c3RzKSkgew0KPj4gICAgICAgICAgICBzcGluX3VubG9jaygmZmxjdHgtPmZsY19sb2NrKTsNCj4+
ICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAgICAgICAgfQ0KPj4gICAgfQ0KPj4gICAgc3Bp
bl91bmxvY2soJmZsY3R4LT5mbGNfbG9jayk7DQo+PiAgICByZXR1cm4gZmFsc2U7DQo+PiB9DQo+
PiBFWFBPUlRfU1lNQk9MKGxvY2tzX293bmVyX2hhc19ibG9ja2Vycyk7DQo+PiANCj4+IEFzIGEg
c3Vic2VxdWVudCBjbGVhbiB1cCAod2hpY2ggYW55b25lIGNhbiBkbyBhdCBhIGxhdGVyIHBvaW50
KSwNCj4+IGEgc2ltaWxhciBjaGFuZ2UgY291bGQgYmUgZG9uZSB0byBjaGVja19mb3JfbG9ja3Mo
KS4gVGhpcyBiaXQgb2YNCj4+IGNvZGUgc2VlbXMgdG8gYXBwZWFyIGluIHNldmVyYWwgb3RoZXIg
ZmlsZXN5c3RlbXMsIGZvciBleGFtcGxlOg0KPiANCj4gSSB1c2VkIGNoZWNrX2Zvcl9sb2NrcyBh
cyByZWZlcmVuY2UgZm9yIGxvY2tzX293bmVyX2hhc19ibG9ja2Vycw0KPiBzbyBib3RoIHNob3Vs
ZCBiZSB1cGRhdGVkIHRvIGJlIG1vcmUga0FCSSBmcmllbmRseSBhcyB5b3Ugc3VnZ2VzdGVkLg0K
PiBDYW4gSSB1cGRhdGUgYm90aCBpbiBhIHN1YnNlcXVlbnQgY2xlYW51cCBwYXRjaD8NCg0KTm8u
IEkgcHJlZmVyIHRoYXQgeW91IGRvbuKAmXQgaW50cm9kdWNlIGNvZGUgYW5kIHRoZW4gY2xlYW4g
aXQgdXAgbGF0ZXIgaW4gdGhlIHNhbWUgc2VyaWVzLg0KDQpZb3UgbmVlZCB0byBpbnRyb2R1Y2Ug
bG9ja3Nfb3duZXJfaGFzX2Jsb2NrZXJzKCkgaW4gdGhlIHNhbWUgcGF0Y2ggd2hlcmUgeW91IGFk
ZCB0aGUgbmZzZDRfIGZ1bmN0aW9uIHRoYXQgd2lsbCB1c2UgaXQuIEkgdGhpbmsgdGhhdOKAmXMg
bGlrZSA3IG9yIDgvMTEgPyBJIGRvbuKAmXQgaGF2ZSBpdCBpbiBmcm9udCBvZiBtZS4NCg0KQmVj
YXVzZSBpdCBkZWR1cGxpY2F0ZXMgY29kZSwgY2xlYW5pbmcgdXAgY2hlY2tfZm9yX2xvY2tzKCkg
d2lsbCBuZWVkIHRvIGludm9sdmUgYXQgbGVhc3Qgb25lIG90aGVyIHNpdGUgKG91dHNpZGUgb2Yg
TkZTRCkgdGhhdCBjYW4gbWFrZSB1c2Ugb2YgdGhpcyBuZXcgaGVscGVyLiBUaGVyZWZvcmUgSSBw
cmVmZXIgdGhhdCB5b3Ugd2FpdCBhbmQgZG8gdGhhdCB3b3JrIGFmdGVyIGNvdXJ0ZW91cyBzZXJ2
ZXIgaXMgbWVyZ2VkLg0KDQoNCj4gSSBwbGFuIHRvIGhhdmUgYSBudW1iZXIgb2Ygc21hbGwgY2xl
YW51cCB1cCBwYXRjaGVzIGZvciB0aGVzZSBhbmQgYWxzbyBzb21lIG5pdHMuDQoNCkNsZWFuLXVw
cyBvZiBhcmVhcyBub3QgaGF2aW5nIHRvIGRvIHdpdGggY291cnRlb3VzIHNlcnZlciBjYW4gZ28g
aW4gc2VwYXJhdGUgcGF0Y2hlcywgYnV0IEkgd291bGQgcHJlZmVyIHRvIGtlZXAgY2xlYW4tdXBz
IG9mIHRoZSBuZXcgY29kZSBpbiB0aGlzIHNlcmllcyBpbnRlZ3JhdGVkIHRvZ2V0aGVyIGluIHRo
ZSBzYW1lIHBhdGNoZXMgd2l0aCB0aGUgbmV3IGNvZGUuDQoNCkxldOKAmXMgc3RheSBmb2N1c2Vk
IG9uIGZpbmlzaGluZyB0aGUgY291cnRlb3VzIHNlcnZlciB3b3JrIGFuZCBnZXR0aW5nIGl0IG1l
cmdlZC4NCg0KDQo+IFRoYW5rcywNCj4gLURhaQ0KPiANCj4gDQo+PiANCj4+IDc2NDMgICAgICAg
ICBpbm9kZSA9IGxvY2tzX2lub2RlKG5mLT5uZl9maWxlKTsNCj4+IDc2NDQgICAgICAgICBmbGN0
eCA9IGlub2RlLT5pX2ZsY3R4Ow0KPj4gNzY0NQ0KPj4gNzY0NiAgICAgICAgIGlmIChmbGN0eCAm
JiAhbGlzdF9lbXB0eV9jYXJlZnVsKCZmbGN0eC0+ZmxjX3Bvc2l4KSkgew0KPj4gNzY0NyAgICAg
ICAgICAgICAgICAgc3Bpbl9sb2NrKCZmbGN0eC0+ZmxjX2xvY2spOw0KPj4gNzY0OCAgICAgICAg
ICAgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShmbCwgJmZsY3R4LT5mbGNfcG9zaXgsIGZsX2xp
c3QpIHsNCj4+IDc2NDkgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGZsLT5mbF9vd25lciA9
PSAoZmxfb3duZXJfdClsb3duZXIpIHsNCj4+IDc2NTAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdGF0dXMgPSB0cnVlOw0KPj4gNzY1MSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPj4gNzY1MiAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiA3NjUz
ICAgICAgICAgICAgICAgICB9DQo+PiA3NjU0ICAgICAgICAgICAgICAgICBzcGluX3VubG9jaygm
ZmxjdHgtPmZsY19sb2NrKTsNCj4+IDc2NTUgICAgICAgICB9DQo+PiANCj4+IA0KPj4gLS0NCj4+
IENodWNrIExldmVyDQo+PiANCj4+IA0KPj4gDQo=
