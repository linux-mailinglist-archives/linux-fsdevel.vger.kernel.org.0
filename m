Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6014D4611
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 12:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241745AbiCJLom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 06:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240538AbiCJLol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:44:41 -0500
X-Greylist: delayed 504 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 03:43:40 PST
Received: from mx0b-003b2802.pphosted.com (mx0b-003b2802.pphosted.com [205.220.180.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B9140749;
        Thu, 10 Mar 2022 03:43:40 -0800 (PST)
Received: from pps.filterd (m0278971.ppops.net [127.0.0.1])
        by mx0a-003b2802.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AALP0b003068;
        Thu, 10 Mar 2022 11:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=25s5NkEcQCCJjFVMXXAWFer0ipiNjN1rUdKuuxVk1Wg=;
 b=ODyK0uYtWv/EMDD1UNDfDIGZBBc0lE2eeId0TX8gGse7yQfx/Gzys45xqMurPUjv92M8
 0I9bvnsCSThtyiMDQI/X9N0LpfuSBhm8SEZ8knvYtPc9Ux0lyIBDtAwqxaHlhE8Pj898
 M/Rd+E15k1OO3OAqhsbRi4VdB//RfeLa0tk9/+D2rNUIP9q3CKeTxwm5fqaXTy2PsHlM
 roVvT1hg8ZY/NA3AvTJDmtBVaw531A19JFwprVM52C3GKRuN7zmDNzkBhDSFuOQDjk7x
 /rf9y5w14oCmmVXEXXipbWbmpYpBTc8lUgOumsCsE0PK242MQVKJxwVVzTk0efpzcohF 4Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-003b2802.pphosted.com (PPS) with ESMTPS id 3ekx3wn2sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Mar 2022 11:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA5D5EzNnaf77nqKdb4s94Sx0d/f+gFctik6rbxRMW6XR6tmI8Os9+z43YKLwqYdkHgf0eyba6wZHPBQnVKyaLr8lIglTEAAZZAKDESDhklkfg0ud0AH5ZZcQYBXWV9ZLuW+grOs3pO1tmNf+6Ox9mPJboGBeZNvtH/bZiydzydS8dwe1JVvEIehEFQqiKSFckUynuwn8HsEUu3ND8Zcdq5cKmFAQfhAip2Rvvx4Nk2mocwRkpUcU9u9PMlyIQbtoGp4KTdWZ86niiObxRprbM0sAztunwzZIh7jzccStMP7msrJH9fOIS6F4DzTwKKMtedHGbck53Nkumx9/sgqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25s5NkEcQCCJjFVMXXAWFer0ipiNjN1rUdKuuxVk1Wg=;
 b=fRoyoZKm2H9q827wXw5IUyjMmeiu3ByBztcVb26aZ5XtKluulvYCHbKmYJCyQikLRFuyv2Nk9yKDNAh5zat9HoGVSXkqhK5DYoS+DKFPm10gtLKbG5uGBRNXPkLHgexvu/V1ptStiUrYz4rpf7XBbhVMDz8Q4Q//xJmsw4bKqtUG/66VxWkEgHEfGpVSSxwRIabjeeU5k9iNTWox3ee6fhNsOWJso/OiUyH4f8wADJcDDM1T+60AKbnoM01FD7SP2o5DfkXWcaXDfqKy1yIcCJvbuGsuMExjVDMyOp5slEm/ZrSQdfF9R9xprQYRo36ku2NWQ4BQQ1x0ZXF/ayEHpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
Received: from CO3PR08MB7975.namprd08.prod.outlook.com (2603:10b6:303:166::10)
 by MWHPR08MB3533.namprd08.prod.outlook.com (2603:10b6:301:6b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 11:34:40 +0000
Received: from CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac]) by CO3PR08MB7975.namprd08.prod.outlook.com
 ([fe80::106d:1c1:99ae:45ac%9]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 11:34:40 +0000
From:   "Luca Porzio (lporzio)" <lporzio@micron.com>
To:     Manjong Lee <mj0123.lee@samsung.com>,
        "david@fromorbit.com" <david@fromorbit.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "song@kernel.org" <song@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>
Subject: RE: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Topic: [EXT] Re: [PATCH 2/2] block: remove the per-bio/request write
 hint.
Thread-Index: AQHYM213hUiroX0Mx0m03tMAg0KZ2Ky4fWtA
Date:   Thu, 10 Mar 2022 11:34:40 +0000
Message-ID: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
References: <20220306231727.GP3927073@dread.disaster.area>
        <CGME20220309042324epcas1p111312e20f4429dc3a17172458284a923@epcas1p1.samsung.com>
 <20220309133119.6915-1-mj0123.lee@samsung.com>
In-Reply-To: <20220309133119.6915-1-mj0123.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2022-03-10T11:31:24Z;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=5fd1fc91-79aa-474b-b663-e56cb9095710;
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3ad27dd-15dc-437d-8bb6-08da0289f6e4
x-ms-traffictypediagnostic: MWHPR08MB3533:EE_
x-microsoft-antispam-prvs: <MWHPR08MB353303E25121F8C1142000AADC0B9@MWHPR08MB3533.namprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8m+AKIz5bTanuaV6wtttso3gXWw4X9ZiEj2ThdxKHmkDv5PaLeKkCJAQTjixmKQe61OQDbM6UEbSiOw7lVDMjwTF/zdbMee9mbi9EsXQNmSZprLB4O+t/9t/xpfTY7N0tj4yGD38+CBp3/1QYMEfU5o+ds4R2la0BI9dL7P56bxhaWR80gHTDJjwHqhkCWnQEdPUJxe3lnooPH8bChHwxOTz48NyZc42nPShhX9WtbskbEF0UtMebC9bQP+RMIW1KEDf1C/BP8otDO8UuYjA/zF+PzWWGtpXqX5Fdhb/7j7Aw/Nw38JFowczJpr+Lg53mzQ9LmJnHwK2RgAUCzWDuug/HYtuhZtVnmK67GxXmFUzSYnn7tbVq28bo0nZzm76jeUJhRD2mGvjtpNbmJ51fvVC4I4cTBHzJKuXVvZUdr8QG6W+fmbrqn2hHgOjkxtlX6TprBJwn+YEap0ykRJP5gkryCQGA2Oao5BTS+QTO16NFA659MjecyXVpUTSzj5SXBlxj8l+rwdsDKs3dZII15km5tl0pTwBXZKOStXdmbVMMAuRk/tEDB1f9k/15eQ0TGikKwsiEvj4meOqBTz8mRu4BCZQ7yP4XB/1mVdcxs7S9+V5IGJFKP01UXRhV2OhzMEPUh2G9zUrSODHI5XQ6YDys0OhrBJaaUocEmcHJWhFO0kcjV+4hTk3bsvdxPIDJ48W2Y0+n37DV9uAPZ/X1Gvo9lQmN+HEoqUKyXU5m+usBJt0a1+WnA5EgLtORZxirPQWcDcmYJRBe0WvUYZoUhpIG7MDPDYEpWPofuvJ5k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO3PR08MB7975.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(33656002)(508600001)(966005)(83380400001)(86362001)(6506007)(9686003)(7696005)(53546011)(38100700002)(71200400001)(55016003)(26005)(84970400001)(186003)(66476007)(66446008)(66946007)(64756008)(66556008)(4326008)(76116006)(8676002)(38070700005)(52536014)(5660300002)(2906002)(8936002)(7416002)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDlIOW9QUnZ1alhMdTFwQXFoK1orNStYV2ZWb0tDY1JXUFhZMHJHMU9TY0p4?=
 =?utf-8?B?citvUkthNmFMQzFnUHBYSXJXdmx5ZWEyOWZadjd1YUtiN09YYmt3cG5xMkNR?=
 =?utf-8?B?Uis4SEZRTnJEdUVXekx2WlhnRE1KVTVZT1NUNVhFWFdDRlpTZFZ0bUo2U2pi?=
 =?utf-8?B?aUlOckpHUmFHclkxanQvcG84dEFSVmliUFU2NnhlY3pzeWZJb0tLNUN6WUMx?=
 =?utf-8?B?U1M0TU4vSDQ4RnNGWlNtK0w0SGhoWnZMYWVWdzd2SjRsbC95eUI4SkJZNEFG?=
 =?utf-8?B?WEVVRmVTVWpsOGhjTG45Y1NrSTFEM1plMDRuUjBiUVVRVEw3T1JNMU5pVWZu?=
 =?utf-8?B?cFp5Y0tESW9ULzlHWTJNUnRqVVpjSHp2NVViOEN1aU1hdkc0WERxNTJYRzNW?=
 =?utf-8?B?YVl3RUZSWGJzWEZFR1JuTjJ4RDdKYWhMQlpFQ0tvNEwxQXVSWUtqMEN3TVY4?=
 =?utf-8?B?cEYyeklYRDZXb2MrdHdsSVBhdmVPc3QzdS9LbmNheFBibTB4Um1qV2xocUpL?=
 =?utf-8?B?K1lBMUUyNlFYSGFkbFZ4RzVHdkxkZFlQbFhNRk5lR0VJMGlwSnNKSlZUT3Fz?=
 =?utf-8?B?TVpsU21pYmVSTklmcU9sc1B6MTFlQU5NRkZydmxzWktva21oMTZ1S1JPZzdu?=
 =?utf-8?B?UUFjSlpocy9iNm8zNFJPbFNUWFhHNGRwaktmUzc3RE4xT0dUdmVXSitmT0JZ?=
 =?utf-8?B?SUUzWStuZk5KeEhoS3BTWDdOelk0M2VyeUNWaTQ2Z0dnek1ZelhCV1lIcnpE?=
 =?utf-8?B?K2ZTWGFvQlBMREFNUFlNZWpTVk9tSmdRc01tTFZiY1AxUlUrYjM1QkwyWHQ4?=
 =?utf-8?B?SEs4S09ZdHdOQlFtQ3JrQnd5THUxSENPQWo4aHZSeHoxdXhMZ0F5QmNXK1dr?=
 =?utf-8?B?M1lvWG1kZTRRUDBRSjNKZGl4c1l0RGhzcUxvY3hpNitWYmdjZXg0SVNBMkV3?=
 =?utf-8?B?d3hoanNpRFBqK2ZlbVRwZjFDT0gvQXhKQkdyL0xvMU1ZUW4rcDBIRy82enFo?=
 =?utf-8?B?UlNxaTNHWWg0clhjYWVZL1JvS2ltYjZrVXoxVis4RmtqREJXbCtkS3kzSk9Y?=
 =?utf-8?B?bUxjSFVqNnQySGt6ZTBZZGNteEZwaEd2OTVnWUJyNUdUc3BYNHpIM0RkK2RP?=
 =?utf-8?B?dGFHZG1sb0h3Y2ZtWkZlNEg3bHVra096bE1FQ0JtWTlKUmJDT0hMcnZPOTdm?=
 =?utf-8?B?c2RQSXloSS93SnVOOXBHL1hpdGJ5U0ErOFBtMFFGd3dGekU0SnNTektZN1BL?=
 =?utf-8?B?R09UWU5jYS9lOFFDTmZWSGJCYXdUQUdkdUUyMEhpc1hJY1l6QkE0dXE5WnBE?=
 =?utf-8?B?NzhGVkNSdFBxRzlSNmJNM3o0UTA2WE9FV214THl4RGRyeHFTbFF6V2FzRWs5?=
 =?utf-8?B?b09TbUwyOC9iTTJZaWJRM2k0NVR2WS93TitRT2Qrc1pYWjFiT2s3blhQTXZY?=
 =?utf-8?B?SWR6Vnh6R3UwdW11NXpucFNJUVdCelI5ak12eXV4azBxS2VNaXVaNTh2d3Bm?=
 =?utf-8?B?SzFkbzlUS2FNU3JZZ0haSHpaN2kxcnllYVMzWTg2RXdHcVIyVjNxaUpZT1Rs?=
 =?utf-8?B?TVBjTU5IbndyY3ZvY1dBUWx2ZWkxbmluK0lmZ1NHaFBNVFVpajFTWWFsVy9K?=
 =?utf-8?B?QTgwL3haMUF5MkJBMHgzR3BVOFRsQzJtTWhlUjhuZHA3enNEMitEdGx0T0U4?=
 =?utf-8?B?Y0xybVNidkp0WnlnODgyTVhndlE3QjAxQ05nVllMeEkweTljRWNVV0s0bzVC?=
 =?utf-8?B?NFVHTnJ2VmFlckl1eEZqOVpORHJjRWxTVUMvMVlPQ2hnZHBDK3BuVDNHbUIr?=
 =?utf-8?B?d1NzbkU2eHNadFRLbVpuamJLd0R6eHd4aUo5YWlIdGRjQzB0NXptQ1NQbHdr?=
 =?utf-8?B?NTZwamt0YVpxOUZOUGVLbi95WExzNnVuRmZjck5SVGNoZUFMQTdlbFo3N0t1?=
 =?utf-8?Q?sz4Wqj4R5BfObjkJxfhhDA7FLTyz8YAQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO3PR08MB7975.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ad27dd-15dc-437d-8bb6-08da0289f6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 11:34:40.1201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPT7JFYNOMSr7LiI65evP1zl/V4uhKD3hQiMhf1/y8K23dR5xAZgLJBtO9jKs7Cw3rFZf6X8uL1YI/gUo67g6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR08MB3533
X-Proofpoint-GUID: -K2UL37JvJ__vRxSVov9idY0vZos8LK5
X-Proofpoint-ORIG-GUID: -K2UL37JvJ__vRxSVov9idY0vZos8LK5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5qb25nIExlZSA8bWowMTIz
LmxlZUBzYW1zdW5nLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCA5LCAyMDIyIDI6MzEg
UE0NCj4gVG86IGRhdmlkQGZyb21vcmJpdC5jb20NCj4gQ2M6IGF4Ym9lQGtlcm5lbC5kazsgaGNo
QGxzdC5kZTsga2J1c2NoQGtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBibG9ja0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gbnZtZUBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1yYWlkQHZnZXIua2VybmVsLm9yZzsgc2FnaUBncmltYmVyZy5t
ZTsNCj4gc29uZ0BrZXJuZWwub3JnOyBzZXVuZ2h3YW4uaHl1bkBzYW1zdW5nLmNvbTsNCj4gc29v
a3dhbjcua2ltQHNhbXN1bmcuY29tOyBuYW5pY2gubGVlQHNhbXN1bmcuY29tOw0KPiB3b29zdW5n
Mi5sZWVAc2Ftc3VuZy5jb207IHl0MDkyOC5raW1Ac2Ftc3VuZy5jb207DQo+IGp1bmhvODkua2lt
QHNhbXN1bmcuY29tOyBqaXNvbzIxNDYub2hAc2Ftc3VuZy5jb20NCj4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCAyLzJdIGJsb2NrOiByZW1vdmUgdGhlIHBlci1iaW8vcmVxdWVzdCB3cml0ZSBo
aW50Lg0KPiANCj4gQ0FVVElPTjogRVhURVJOQUwgRU1BSUwuIERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcw0KPiB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5k
IHdlcmUgZXhwZWN0aW5nIHRoaXMgbWVzc2FnZS4NCj4gDQo+IA0KPiA+T24gU3VuLCBkZE1hciAw
NiwgMjAyMiBhdCAxMTowNjoxMkFNIC0wNzAwLCBKZW5zIEF4Ym9lIHdyb3RlOg0KPiA+PiBPbiAz
LzYvMjIgMTE6MDEgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+PiA+IE9uIFN1biwg
TWFyIDA2LCAyMDIyIGF0IDEwOjExOjQ2QU0gLTA3MDAsIEplbnMgQXhib2Ugd3JvdGU6DQo+ID4+
ID4+IFllcywgSSB0aGluayB3ZSBzaG91bGQga2lsbCBpdC4gSWYgd2UgcmV0YWluIHRoZSBpbm9k
ZSBoaW50LCB0aGUNCj4gPj4gPj4gZjJmcyBkb2Vzbid0IG5lZWQgYSBhbnkgY2hhbmdlcy4gQW5k
IGl0IHNob3VsZCBiZSBzYWZlIHRvIG1ha2UgdGhlDQo+ID4+ID4+IHBlci1maWxlIGZjbnRsIGhp
bnRzIHJldHVybiBFSU5WQUwsIHdoaWNoIHRoZXkgd291bGQgb24gb2xkZXIga2VybmVscw0KPiBh
bnl3YXkuDQo+ID4+ID4+IFVudGVzdGVkLCBidXQgc29tZXRoaW5nIGxpa2UgdGhlIGJlbG93Lg0K
PiA+PiA+DQo+ID4+ID4gSSd2ZSBzZW50IHRoaXMgb2ZmIHRvIHRoZSB0ZXN0aW5nIGZhcm0gdGhp
cyBtb3JuaW5nLCBidXQgRUlOVkFMDQo+ID4+ID4gbWlnaHQgYmUgZXZlbiBiZXR0ZXI6DQo+ID4+
ID4NCj4gPj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2dpdC5pbmZyYWRl
YWQub3JnL3VzZXJzL2hjaC9ibG9jDQo+ID4+ID4gay5naXQvc2hvcnRsb2cvcmVmcy9oZWFkcy9t
b3JlLWhpbnQtDQo+IHJlbW92YWxfXzshIUtaVGRPQ2poZ3Q0aGd3IXFzZ3kNCj4gPj4gPg0KPiBv
ZWpjaFVZUGVvcnBDTDBPdjNqUEd2WHBYZ3hhN2hwU0NWaUQ3WFF5N3VKRE1ETG8zVTh2X2Jtb1V0
ZyQNCj4gPg0KPiA+WXVwLCBJIGxpa2UgdGhhdC4NCj4gPg0KPiA+PiBJIGRvIHRoaW5rIEVJTlZB
TCBpcyBiZXR0ZXIsIGFzIGl0IGp1c3QgdGVsbHMgdGhlIGFwcCBpdCdzIG5vdA0KPiA+PiBhdmFp
bGFibGUgbGlrZSB3ZSB3b3VsZCd2ZSBkb25lIGJlZm9yZS4gV2l0aCBqdXN0IGRvaW5nIHplcm9l
cywgdGhhdA0KPiA+PiBtaWdodCBicmVhayBhcHBsaWNhdGlvbnMgdGhhdCBzZXQtYW5kLXZlcmlm
eS4gT2YgY291cnNlIHRoZXJlJ3MgYWxzbw0KPiA+PiB0aGUgcmlzayBvZiB0aGF0IHNpbmNlIHdl
IHJldGFpbiBpbm9kZSBoaW50cyAoc28gdGhleSB3b3JrKSwgYnV0IGZhaWwgZmlsZQ0KPiBoaW50
cy4NCj4gPj4gVGhhdCdzIGEgbGVzc2VyIHJpc2sgdGhvdWdoLCBhbmQgd2Ugb25seSBrbm93IG9m
IHRoZSBpbm9kZSBoaW50cw0KPiA+PiBiZWluZyB1c2VkLg0KPiA+DQo+ID5BZ3JlZWQsIEkgdGhp
bmsgRUlOVkFMIHdvdWxkIGJlIGJldHRlciBoZXJlIC0ganN1dCBtYWtlIGl0IGJlaGF2ZSBsaWtl
DQo+ID5pdCB3b3VsZCBvbiBhIGtlcm5lbCB0aGF0IG5ldmVyIHN1cHBvcnRlZCB0aGlzIGZ1bmN0
aW9uYWxpdHkgaW4gdGhlDQo+ID5maXJzdCBwbGFjZS4gU2VlbXMgc2ltcGxlciB0byBtZSBmb3Ig
dXNlciBhcHBsaWNhdGlvbnMgaWYgd2UgZG8gdGhhdC4NCj4gPg0KPiA+Q2hlZXJzLA0KPiA+DQo+
ID5EYXZlLg0KPiA+LS0NCj4gPkRhdmUgQ2hpbm5lcg0KPiA+ZGF2aWRAZnJvbW9yYml0LmNvbQ0K
PiA+DQo+IA0KPiBDdXJyZW50bHksIFVGUyBkZXZpY2UgYWxzbyBzdXBwb3J0cyBob3QvY29sZCBk
YXRhIHNlcGFyYXRpb24gYW5kIHVzZXMNCj4gZXhpc3Rpbmcgd3JpdGVfaGludCBjb2RlLg0KPiAN
Cj4gSW4gb3RoZXIgd29yZHMsIHRoZSBmdW5jdGlvbiBpcyBhbHNvIGJlaW5nIHVzZWQgaW4gc3Rv
cmFnZSBvdGhlciB0aGFuIE5WTWUsDQo+IGFuZCBpZiBpdCBpcyByZW1vdmVkLCBpdCBpcyB0aG91
Z2h0IHRoYXQgdGhlcmUgd2lsbCBiZSBhbiBvcGVyYXRpb24gcHJvYmxlbS4NCj4gDQo+IElmIHRo
ZSBjb2RlIGlzIHJlbW92ZWQsIEkgYW0gd29ycmllZCBhYm91dCBob3cgb3RoZXIgZGV2aWNlcyB0
aGF0IHVzZSB0aGUNCj4gZnVuY3Rpb24uDQo+IA0KPiBJcyB0aGVyZSBhIGdvb2QgYWx0ZXJuYXRp
dmU/DQoNCkhpIGFsbCwNCg0KSSB3b3JrIGZvciBNaWNyb24gVUZTIHRlYW0uIEkgY29uZmlybSBh
bmQgc3VwcG9ydCBNYW5qb25nIG1lc3NhZ2UgYWJvdmUuDQpUaGVyZSBhcmUgVUZTIGN1c3RvbWVy
cyB1c2luZyBjdXN0b20gd3JpdGVfaGludCBpbiBBbmRyb2lkIGFuZCBkdWUgdG8gdGhlIA0KInVw
c3RyZWFtIGZpcnN0IiBwb2xpY3kgZnJvbSBHb29nbGUsIGlmIHlvdSByZW1vdmUgd3JpdGVfaGlu
dHMgaW4gYmxvY2sgZGV2aWNlLA0KVGhlIEFuZHJvaWQgZWNvc3lzdGVtIHdpbGwgc3VmZmVyIHRo
aXMgbGFjay4NCg0KQ2FuIHdlIHJldmVydCBiYWNrIHRoaXMgZGVjaXNpb24/IE9yIHRoaW5rIG9m
IGFuIGFsdGVybmF0aXZlIHNvbHV0aW9uIHdoaWNoIA0KbWF5IHdvcms/DQoNCkNoZWVycywNCiAg
IEx1Y2ENCg==
