Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFA478BD97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 06:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjH2Eu7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 00:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjH2Euz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:50:55 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3085C1A1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 21:50:47 -0700 (PDT)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SN0fYC017063;
        Tue, 29 Aug 2023 04:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=pJ8lL+feJg/f4Rvxpz8FM8tisfvmxGCxc0Jb5PBfpCY=;
 b=Gj8OLYKex4zEykYy3xRp986f10DjJ8MxP7nvyTvT4uc+1rRxvOjv2m+qkPH4b1aRzB/d
 PRWVG4j1WO40sogvq7kgMwjWMHTKkBdfFjZNp3/ILExPF4YzC/0CSHRVkbNV81lTMv1F
 zfxz97RBlUGkJEdvgfUKID/qONMiMeNK396dQyKaxbmKb7yA9S5/6wXKzySppLSCThDZ
 n8dDQZorffOPiUueoYxjFESNN1F0BnkV6nUejUeaWRwR3qKkIxTM8z7WZ82ONhGmslGa
 nYm+w3UhFsF926hY0J3lNQa676uJAhxYbUho1wu3IJWSbb1fdDb3SHOpZ9njm4HmeAZK nw== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2112.outbound.protection.outlook.com [104.47.26.112])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3sq9hpj7jq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 04:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0+8nbnRhH+bL+wMf+Sd1/oICDIPpNeL8r8MjCRomgtZMm3rLa6KxiFx6/IZfXwFfn7egt/lgBDuaDRgrl4FBP1rSzAvktK91iCMUDLh2rb/kEllZQr2pAyv/fpYpnINfiDvFsSR5PY3rWhzYzQ1vEtg0RQkCrHV1GQRgphWzxUr1aiXwop/qdge+IA3YbgX9qdzUn3hLk1i45rmbyXuGIRZ27Y7v9h0g/LYQLhx5Y+RJQFtBBMAbHFaRI6Q1A5es84ZQgXbl689GIzz53cfPqp8bdU8s6efR/eRIFhOkqAsXLBEjyD/70CeHq7MOFdu+2tgGFi01Gc9ufYm84md9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ8lL+feJg/f4Rvxpz8FM8tisfvmxGCxc0Jb5PBfpCY=;
 b=kvqu3MV1TztVcwNhMVTCOcL+tqP7SjHR0P7CZWkTZYZ2tVZn2DJfPi7mTx8tbUZ9eBlUXIjWI12yC2TjoX4TuiehcjpU4Mk5XqNHIJC0oG6bFC08Y1qNlAQA/23n++jPxnnwPNT1qROkbX0+srYDhS46ANppmmuF6lpOpqi4Yzw4S7kRRQ5ZpefhF6kc/U84YjjhY3NegZpYoAuACfYUYng23kbxAKqEqEXBelcKXsF4nyn0mEmpwMhu64OtnVwJOl4nUggo7Qjlq9gJiLjLwrQ2OMcDYYMsigwoW67bWTQ73ltcA6Fu6RYcV1zRVwpgDQ45rq4jcjomYjo0OL3qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4340.apcprd04.prod.outlook.com (2603:1096:820:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 04:50:30 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 04:50:30 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 2/2] exfat: support create zero-size directory
Thread-Topic: [PATCH v1 2/2] exfat: support create zero-size directory
Thread-Index: AdnaNBrmKC9P4VmURO2B4RgAsTksTw==
Date:   Tue, 29 Aug 2023 04:50:30 +0000
Message-ID: <PUZPR04MB631677F6E573FC9062A2BF2981E7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4340:EE_
x-ms-office365-filtering-correlation-id: b5a17500-e2aa-42e6-ddee-08dba84b789f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z077RsQSdqG6NjGeUVA4LzN+HIyZa55yaFpE1Jcav9lD3PaKQrE5H2lRw+ZEwv3L6QNTf9KCgTcpr07BrShvQAs42ckQvP9BJdU50tN5gQrLqv0fvr3JOB4Zc/byPi66cGbAD+0xXGdLz8JRjFDl+exUxdOKpO6wNHTxhIIMS7hdkBRVakAzjX3oSWn3XqYhTDhf0vJF2ldtvEujJYn/7LTalmQX35ULV5w5roSrczPifKVGBa1JVw2w0uesIR+wDQQMfKzdAb7oquMyVLjOx5xY9Ie0eoH3gO80Zy40W+8MTuN+iVN9eWyAU+16/qpFNcg0o8O6kdjTbfot8hHR6J1reLrL8TDE+QJBr9AykP1Er7dt14svw787OOcqMuMiZLdr8V/+szJ/FS/wyLWefqhB3MpAb3ybZ7q7v/UuoV7sXwVKVR8wOyDQ3WVTs3YRutgsOAVeYnh63AJn5mzHtLjguIUy/wJJEdl4TJq+2NEG33jfclfofQ5hMKl82rn05IZojq540aLZn24sS/h0O4m0wr131xZimrLX9iAOWItxZHunRAQhQqPVi5qG86scVjdFBHVGc/3YCAPkzRYQRf7koQJSdg280YcCJQn9Qts8OqQH9//tmE4yjXthSEHt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(9686003)(7696005)(6506007)(71200400001)(478600001)(83380400001)(107886003)(76116006)(26005)(2906002)(54906003)(316002)(64756008)(66446008)(66476007)(66946007)(52536014)(66556008)(110136005)(41300700001)(8936002)(5660300002)(8676002)(4326008)(33656002)(55016003)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm9JYm5hQkQ2TlhiM2lRcndsaGZBSlRGZkV4QkcrK2E2SW00MDROSWYva1Yy?=
 =?utf-8?B?cFQyV25hTU1yMVZKQlliQjkwVmZ5d25VT3ZLcmNxbnlnT1pRZm9mRzcvUGVm?=
 =?utf-8?B?eWdiQzZFa2ErSlBJcmlVclpsUy9YN3Y2M0FQV09ieG51QjFZT1hWVXZFTGxB?=
 =?utf-8?B?SFRQQng4TzlsMEg0cko4Z3I3T1puNWhYUEZXc0FwSHg2UUlZMm8vdUc3czhZ?=
 =?utf-8?B?ZHd4Z05mdDZJam96bmJ4dmtDL2tDRkNJT1hEYUZvZXZ2M2UyUzFNbnE0Z0ho?=
 =?utf-8?B?WWJHcXJIT243SWhMQUk5Z2QzWkdFOXlJbitUOHRrWjVqczBScS9ORVFiSkJz?=
 =?utf-8?B?RGpjbE05ckRPaFRjcWlGMG5YMVJxU0dwS1g1cEVqQ25VaWhDNDMzQjFIbWlM?=
 =?utf-8?B?a1FhSnRKRE5NeDBnTlVvUDVJM042a1Z2MmtWZVY0bllsRWVqa0hiN1JWV21B?=
 =?utf-8?B?UzB6cWxQWVA2RlJ4MDE0MnV1TGhsaDRsa3B0ejZKcFBmWTNPdnRBUFNVMHJz?=
 =?utf-8?B?RmxITm9rSlZZQjZ0RXdvcXJMR0pxVkhBbnpwV0V2OW9TV2VLZERuckw5K0xQ?=
 =?utf-8?B?M1pNMFhLc0h5anNUcTJEb0hxem4wYmVmU01yc1MvMUNMUHBVNkhjNHVVM3RX?=
 =?utf-8?B?WTc5aXZLcm9JNDRMK281NURiMExqVkY1RHRsZm05d1pJK3hyLzNoRjR1RktL?=
 =?utf-8?B?WHJqSFkxNzZWZlZXay9hVyttYS8zSmllaFlkUE5icVZhK1VwS2RBQmJxUHhi?=
 =?utf-8?B?UU5FNytHTlYzd2UxMExDVWk2cTdvekIxMWY5R09BOE9ndHgvMGhBNEZLWGE3?=
 =?utf-8?B?TzRlc1IwdHhaQzUxbUpQSzJ5ZjA2eHhJZFFVemVyWE9vcmx1c0tFNlM0Q3Zz?=
 =?utf-8?B?QXVzWE02MndnTVNCMFMrbkpuOERhUHJNS1Q2U2RrRzNodjFJUmQ5VWk1Qk0y?=
 =?utf-8?B?eStvQ3ZtVVZMa25yZzJKdFI3NVVlSVNrVVo1MEw4aHpFbFVEb3BldUU0aFdD?=
 =?utf-8?B?dnl0YXEzWDYrT25qcVR0SlpoNWZRSitiNWluMDdwbE5rU0NmUnpZV094QmdO?=
 =?utf-8?B?WXp3dzlRa2JndWlnT2JubnZqdUM3WU9id0lXcGp2OVdBVXpra0NleWhDYTcv?=
 =?utf-8?B?RTVsYmYvdjd6U01Bdk5yM0RTcmpBNWpiRk90LzFqQTNZUTFDbDRyK0pJbmNo?=
 =?utf-8?B?V1kweEZXdzFsVlVDa0NGUHBQM3VFS29NZUdiZGk3Z3k0M2VCeXZ5Ujhpd3Az?=
 =?utf-8?B?V3BHL0NCcVpTTVlvek9id3N5NkprUkNiUFY1eU41R1U3SDhpZ3ZNSkRyVUVo?=
 =?utf-8?B?a1Z1cVFtUUFFMVRGemF2dWJjbGdBYzJJN1luenk0anN3RWxBNFBvMDBVWWpo?=
 =?utf-8?B?czdoUmp2ZThYT3A2YmJZUkk4ZE91dUV4WVhzWTlsTWVwOE9TQkNLeTVRdGhG?=
 =?utf-8?B?bVl0dFlGWU53aFBzZUdUbnQ1d3Y3R3FjQ09BSytBaFk0K3hoMUNOYWswKy9m?=
 =?utf-8?B?bmdDWitvUjIxR3RmN2VYZElaWUJxVGRtR3U3NGtJSVdyb0JSd1JGbkVJSlM2?=
 =?utf-8?B?cUxKYUN1VVlyak0zV0ZSRDVTU0hsNnJ4dEdReDI1SHdWV0dKdHVvOWFDa1di?=
 =?utf-8?B?VnZUU2g0QTMzTEMyTGRkMVlBWW9MSVVkM2w4ZGxTUjJQOFRNekZqa3l3MFFh?=
 =?utf-8?B?VU9mRUQvejViV2t6a0ZBYS92azlvL004MzBhenFDZHUvTGFsT0dxMkJwbUxs?=
 =?utf-8?B?Ym8yM1UwVWVvZVJIeUNEYlF5UnJ3RHRLSVJMRFZCZXFnSkVEM2J1NkRNcGJl?=
 =?utf-8?B?NVUzMk1ZNk9XZnhjcHJyMXhBeURuL2l0Wm9peG9JM0xJNThXYU0zTFIyTWxF?=
 =?utf-8?B?ZWQ3K3NXTVJvWmZIT1lUN1VoQmRvUDFlbzFBbHprRE1zOGIrSGx0OGRMM2FC?=
 =?utf-8?B?K3FQOFVCYjBmSWw5eHNNYUFmVW1nUkZVQkM3cjc3Z1A3U2ZiTjV5OURRQW1T?=
 =?utf-8?B?K0Z4NytQOTRXMjNMZlFxZlVuQlRGcDQrVTVEOHhiOFdvUHlaYXdtVGJiR1hx?=
 =?utf-8?B?U0VEd0RFcnZDWm12d0x6Y3hiTFVKeWRMYUZhRFA5V254MndrQW0zRmtjYW9x?=
 =?utf-8?Q?agQtdAIcgh/GDstZh3cA01sYw?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +c/wfOT1WAk6ccGkEkue5pIoh7Dg12+5bZTYvfHBMtC805RFVh3lxnCjjMFpPLi/aawRQF77v+wW8dPI37lxhMiG3URK7CQLC1HiRtwQ7BXfXCF5OIoYvK4CitIRSZbl4paAeguLsElVj6lDaX4RyWUcHYYzqIthAxvIIRxNKJYRx1KT9H86LzkUZoitYqLlpsKCQ/OrgQzeUCCrXmbH7mYwJRabeZkbfoj65l89kxrBd1wAwYDUDSVDTLKzUwqg//EMYKr6u5p8WTgTnBx9DXjgplOtq6t6pZVKkWJ8Tsjpz4C1oLkS+Wi3VvXWcJglrry/URXkdZa4jF3Kn1UF7szvAOFpwUYaMAaGxmek3LOTXSV41wM6F0yD/sR+E9SQCFw4R5BriaRiC+SQME82SslpvUuyLn26g9DxXA0U1clnyQB9JjTDAduJ4ULtv+2quJYLo0AdODnzRcybsmCkphQwZOWGD4D1IEuspG0E5TBNfkXVlyn5apsiTG/+T/Cz9y/9QNhQ7uWVXGBAqwdCYebSY9DxxIP29wsEPueNPD5fSmPV/5/pC88NGOqPowyGFiqjY/gdQ6mePA9dRbYcuQzPe69UgY7HdJXE2CbL4OtzdUd1ZcMTc4068Grt8xVYAbH2nzmi6JxpFrXXF8Z+6FL/fhNKuGGupeAe8gaeLfW4Bc/c7jozNig3Fvns8Fmg7fEx3IS4FkX6CVT+iJvIPQSrNuwnTfN08kSgrZxXpXMcZPiN5SNhmT1twMyrx3kTUJBGlWB+/QX6l/OwChkaScPx5JcfVyx0KQTHusuxUKdpHjyo2R1T2Fy7zRdHqfBL63oGSbEOw3+tVbNMyILDQg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a17500-e2aa-42e6-ddee-08dba84b789f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 04:50:30.2709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2AhPr2TeSZuqZr5uO1KK8TmpI81sp3lmph3N3YUkl2kqsV34VUQIxx+Umbz3GbhCveMdJlIHJMOLBDh0gghQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4340
X-Proofpoint-ORIG-GUID: 1KVPk9FkpFlakBRLnoFSVMxDjQ3Ulh7h
X-Proofpoint-GUID: 1KVPk9FkpFlakBRLnoFSVMxDjQ3Ulh7h
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 1KVPk9FkpFlakBRLnoFSVMxDjQ3Ulh7h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_01,2023-08-28_04,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyBtb3VudCBvcHRpb24gJ3plcm9fc2l6ZV9kaXInLiBJZiB0aGlzIG9w
dGlvbg0KZW5hYmxlZCwgZG9uJ3QgYWxsb2NhdGUgYSBjbHVzdGVyIHRvIGRpcmVjdG9yeSB3aGVu
IGNyZWF0aW5nDQppdCwgYW5kIHNldCB0aGUgZGlyZWN0b3J5IHNpemUgdG8gMC4NCg0KT24gV2lu
ZG93cywgYSBjbHVzdGVyIGlzIGFsbG9jYXRlZCBmb3IgYSBkaXJlY3Rvcnkgd2hlbiBpdCBpcw0K
Y3JlYXRlZCwgc28gdGhlIG1vdW50IG9wdGlvbiBpcyBkaXNhYmxlZCBieSBkZWZhdWx0Lg0KDQpT
aWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0
YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQvZGlyLmMgICAgICB8
IDEyICsrKysrKy0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAgMiArKw0KIGZzL2V4ZmF0
L25hbWVpLmMgICAgfCAgNyArKysrKy0tDQogZnMvZXhmYXQvc3VwZXIuYyAgICB8ICA3ICsrKysr
KysNCiA0IGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9leGZhdC9kaXIuYyBiL2ZzL2V4ZmF0L2Rpci5jDQppbmRleCA1OTgw
ODFkMGQwNTkuLjlhZDVmZjAxNDU2ZSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2Rpci5jDQorKysg
Yi9mcy9leGZhdC9kaXIuYw0KQEAgLTQxNywxMSArNDE3LDEzIEBAIHN0YXRpYyB2b2lkIGV4ZmF0
X3NldF9lbnRyeV90eXBlKHN0cnVjdCBleGZhdF9kZW50cnkgKmVwLCB1bnNpZ25lZCBpbnQgdHlw
ZSkNCiB9DQogDQogc3RhdGljIHZvaWQgZXhmYXRfaW5pdF9zdHJlYW1fZW50cnkoc3RydWN0IGV4
ZmF0X2RlbnRyeSAqZXAsDQotCQl1bnNpZ25lZCBjaGFyIGZsYWdzLCB1bnNpZ25lZCBpbnQgc3Rh
cnRfY2x1LA0KLQkJdW5zaWduZWQgbG9uZyBsb25nIHNpemUpDQorCQl1bnNpZ25lZCBpbnQgc3Rh
cnRfY2x1LCB1bnNpZ25lZCBsb25nIGxvbmcgc2l6ZSkNCiB7DQogCWV4ZmF0X3NldF9lbnRyeV90
eXBlKGVwLCBUWVBFX1NUUkVBTSk7DQotCWVwLT5kZW50cnkuc3RyZWFtLmZsYWdzID0gZmxhZ3M7
DQorCWlmIChzaXplID09IDApDQorCQllcC0+ZGVudHJ5LnN0cmVhbS5mbGFncyA9IEFMTE9DX0ZB
VF9DSEFJTjsNCisJZWxzZQ0KKwkJZXAtPmRlbnRyeS5zdHJlYW0uZmxhZ3MgPSBBTExPQ19OT19G
QVRfQ0hBSU47DQogCWVwLT5kZW50cnkuc3RyZWFtLnN0YXJ0X2NsdSA9IGNwdV90b19sZTMyKHN0
YXJ0X2NsdSk7DQogCWVwLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUgPSBjcHVfdG9fbGU2NChz
aXplKTsNCiAJZXAtPmRlbnRyeS5zdHJlYW0uc2l6ZSA9IGNwdV90b19sZTY0KHNpemUpOw0KQEAg
LTQ4Nyw5ICs0ODksNyBAQCBpbnQgZXhmYXRfaW5pdF9kaXJfZW50cnkoc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGV4ZmF0X2NoYWluICpwX2RpciwNCiAJaWYgKCFlcCkNCiAJCXJldHVybiAt
RUlPOw0KIA0KLQlleGZhdF9pbml0X3N0cmVhbV9lbnRyeShlcCwNCi0JCSh0eXBlID09IFRZUEVf
RklMRSkgPyBBTExPQ19GQVRfQ0hBSU4gOiBBTExPQ19OT19GQVRfQ0hBSU4sDQotCQlzdGFydF9j
bHUsIHNpemUpOw0KKwlleGZhdF9pbml0X3N0cmVhbV9lbnRyeShlcCwgc3RhcnRfY2x1LCBzaXpl
KTsNCiAJZXhmYXRfdXBkYXRlX2JoKGJoLCBJU19ESVJTWU5DKGlub2RlKSk7DQogCWJyZWxzZShi
aCk7DQogDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0
X2ZzLmgNCmluZGV4IDcyOWFkYTllMjZlOC4uY2JmMzI5NDlmZjY3IDEwMDY0NA0KLS0tIGEvZnMv
ZXhmYXQvZXhmYXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTIzNCw2ICsy
MzQsOCBAQCBzdHJ1Y3QgZXhmYXRfbW91bnRfb3B0aW9ucyB7DQogCQkgZGlzY2FyZDoxLCAvKiBJ
c3N1ZSBkaXNjYXJkIHJlcXVlc3RzIG9uIGRlbGV0aW9ucyAqLw0KIAkJIGtlZXBfbGFzdF9kb3Rz
OjE7IC8qIEtlZXAgdHJhaWxpbmcgcGVyaW9kcyBpbiBwYXRocyAqLw0KIAlpbnQgdGltZV9vZmZz
ZXQ7IC8qIE9mZnNldCBvZiB0aW1lc3RhbXBzIGZyb20gVVRDIChpbiBtaW51dGVzKSAqLw0KKwkv
KiBTdXBwb3J0IGNyZWF0aW5nIHplcm8tc2l6ZSBkaXJlY3RvcnksIGRlZmF1bHQ6IGZhbHNlICov
DQorCWJvb2wgemVyb19zaXplX2RpcjsNCiB9Ow0KIA0KIC8qDQpkaWZmIC0tZ2l0IGEvZnMvZXhm
YXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMNCmluZGV4IDQzNzc0NjkzZjY1Zi4uMjMyMjBk
ZDg3NGUzIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFt
ZWkuYw0KQEAgLTUxOCw3ICs1MTgsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X2FkZF9lbnRyeShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBjb25zdCBjaGFyICpwYXRoLA0KIAkJZ290byBvdXQ7DQogCX0NCiAN
Ci0JaWYgKHR5cGUgPT0gVFlQRV9ESVIpIHsNCisJaWYgKHR5cGUgPT0gVFlQRV9ESVIgJiYgIXNi
aS0+b3B0aW9ucy56ZXJvX3NpemVfZGlyKSB7DQogCQlyZXQgPSBleGZhdF9hbGxvY19uZXdfZGly
KGlub2RlLCAmY2x1KTsNCiAJCWlmIChyZXQpDQogCQkJZ290byBvdXQ7DQpAQCAtNTUxLDcgKzU1
MSwxMCBAQCBzdGF0aWMgaW50IGV4ZmF0X2FkZF9lbnRyeShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBj
b25zdCBjaGFyICpwYXRoLA0KIAkJaW5mby0+bnVtX3N1YmRpcnMgPSAwOw0KIAl9IGVsc2Ugew0K
IAkJaW5mby0+YXR0ciA9IEFUVFJfU1VCRElSOw0KLQkJaW5mby0+c3RhcnRfY2x1ID0gc3RhcnRf
Y2x1Ow0KKwkJaWYgKHNiaS0+b3B0aW9ucy56ZXJvX3NpemVfZGlyKQ0KKwkJCWluZm8tPnN0YXJ0
X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVSOw0KKwkJZWxzZQ0KKwkJCWluZm8tPnN0YXJ0X2NsdSA9
IHN0YXJ0X2NsdTsNCiAJCWluZm8tPnNpemUgPSBjbHVfc2l6ZTsNCiAJCWluZm8tPm51bV9zdWJk
aXJzID0gRVhGQVRfTUlOX1NVQkRJUjsNCiAJfQ0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVy
LmMgYi9mcy9leGZhdC9zdXBlci5jDQppbmRleCA4YzMyNDYwZTAzMWUuLmIxZTAzMjc2ZTBhMCAx
MDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L3N1cGVyLmMNCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMNCkBA
IC0xNzQsNiArMTc0LDggQEAgc3RhdGljIGludCBleGZhdF9zaG93X29wdGlvbnMoc3RydWN0IHNl
cV9maWxlICptLCBzdHJ1Y3QgZGVudHJ5ICpyb290KQ0KIAkJc2VxX3B1dHMobSwgIixzeXNfdHoi
KTsNCiAJZWxzZSBpZiAob3B0cy0+dGltZV9vZmZzZXQpDQogCQlzZXFfcHJpbnRmKG0sICIsdGlt
ZV9vZmZzZXQ9JWQiLCBvcHRzLT50aW1lX29mZnNldCk7DQorCWlmIChvcHRzLT56ZXJvX3NpemVf
ZGlyKQ0KKwkJc2VxX3B1dHMobSwgIix6ZXJvX3NpemVfZGlyIik7DQogCXJldHVybiAwOw0KIH0N
CiANCkBAIC0yMTgsNiArMjIwLDcgQEAgZW51bSB7DQogCU9wdF9rZWVwX2xhc3RfZG90cywNCiAJ
T3B0X3N5c190eiwNCiAJT3B0X3RpbWVfb2Zmc2V0LA0KKwlPcHRfemVyb19zaXplX2RpciwNCiAN
CiAJLyogRGVwcmVjYXRlZCBvcHRpb25zICovDQogCU9wdF91dGY4LA0KQEAgLTI0Niw2ICsyNDks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjIGV4ZmF0X3BhcmFtZXRl
cnNbXSA9IHsNCiAJZnNwYXJhbV9mbGFnKCJrZWVwX2xhc3RfZG90cyIsCQlPcHRfa2VlcF9sYXN0
X2RvdHMpLA0KIAlmc3BhcmFtX2ZsYWcoInN5c190eiIsCQkJT3B0X3N5c190eiksDQogCWZzcGFy
YW1fczMyKCJ0aW1lX29mZnNldCIsCQlPcHRfdGltZV9vZmZzZXQpLA0KKwlmc3BhcmFtX2ZsYWco
Inplcm9fc2l6ZV9kaXIiLAkJT3B0X3plcm9fc2l6ZV9kaXIpLA0KIAlfX2ZzcGFyYW0oTlVMTCwg
InV0ZjgiLAkJCU9wdF91dGY4LCBmc19wYXJhbV9kZXByZWNhdGVkLA0KIAkJICBOVUxMKSwNCiAJ
X19mc3BhcmFtKE5VTEwsICJkZWJ1ZyIsCQlPcHRfZGVidWcsIGZzX3BhcmFtX2RlcHJlY2F0ZWQs
DQpAQCAtMzE0LDYgKzMxOCw5IEBAIHN0YXRpYyBpbnQgZXhmYXRfcGFyc2VfcGFyYW0oc3RydWN0
IGZzX2NvbnRleHQgKmZjLCBzdHJ1Y3QgZnNfcGFyYW1ldGVyICpwYXJhbSkNCiAJCQlyZXR1cm4g
LUVJTlZBTDsNCiAJCW9wdHMtPnRpbWVfb2Zmc2V0ID0gcmVzdWx0LmludF8zMjsNCiAJCWJyZWFr
Ow0KKwljYXNlIE9wdF96ZXJvX3NpemVfZGlyOg0KKwkJb3B0cy0+emVyb19zaXplX2RpciA9IHRy
dWU7DQorCQlicmVhazsNCiAJY2FzZSBPcHRfdXRmODoNCiAJY2FzZSBPcHRfZGVidWc6DQogCWNh
c2UgT3B0X25hbWVjYXNlOg0KLS0gDQoyLjI1LjENCg==
