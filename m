Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE29177C739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 07:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234766AbjHOFsB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 01:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbjHOFpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:45:50 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5A4198B
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 22:45:40 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F5WdAX027422;
        Tue, 15 Aug 2023 05:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=2h635snhR9s+PYmjJaolmjVoZctFWHLefv3Y1f8RN1c=;
 b=Vfv1iQF8e9/8f/Ap8X6mpbHP8eDIWvmBg+xqxFz5Z8plGSfw6foXeQlDKqdUdyJhy03A
 rRuu3W2F2GZpqoki92Qo8cod2CGdBb1rINaUlIi3+r0ninwlL9g3cRV9KRXlqsja5FJJ
 2QiRz1ThDNVeL6s58i9fCHK6Yw9dilmgRuVvURfnPQWbBYW8NYVyB3AFjFJXnR8OgyQx
 5T0cozduGb2Cn80/WWnE6T3gdvx702bVHqlZLNCfxYE/nrMuMUkhuAHijaBidE344jhx
 9wNcSxtVjEBKfeP1vI3M7RzpMLZxQXOFHdAwJkwMAE3m2uY5zt6Y6eEk0WyEGZI2dDT/ eg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3se2w4t73d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 05:45:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEWXIGElunI+Nh02F6ncIm/PMvqJI7uSWV8Bx1VLlyBEOk3rGn9/CcwdbpehDTF+tXqLGcCxMzKV1hCcK8HA/bs/ZBQd3DFGiuV1vfJG/ejH/WNRB5Q9AS5UbDd9hE4sjS4JSuyJ8/eTADhZcJJnf3tcpHK3MYWmOogWY1cxOowtuuyOypjoeuQoQMcMQD7RGnWF23SEs3//FPSvNnI98sAw27akb3feqZfVpX92GRWjbc2BeJNIHJQwvMYbMSC8KfOZHhH7nImbSiM5T0x4AyJ+BVBKX2jRBMP9eYfsXZuNHUuuopgD7RIUR9yxvHIAtzYsuAmXFdu2MOPpG/pSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h635snhR9s+PYmjJaolmjVoZctFWHLefv3Y1f8RN1c=;
 b=DscJUqCU1i8ruo+W71cMBN9enD6IFQpWJsCsUQKHsxtaZupHGj63MCukIvtczZNHM0evhE0T7GFhGtwfx+3mPPOQQXZetc45hSanrzZgH41VcQ3EezgAvICTUa7LX0PsLyvmqr9NeCe+RM/J+sMc4yBbqx4D1eiWUiB4NAz5Wll2LK5ma+KWeeE3sP28bzoJCQvlu+ldeOPIqCiohkCXazfBNOH/kFcu+Th1HEGekup5g+cvXAbsx0teLBCr3GPcYw1EaDSYqhCWGAMkvkmBdgcwEA6A/gOZeRYwfRgonP47mqGkmoB8+i9RH4+4DnjG0UnEZB4OIz9A6YjgYcebZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB7129.apcprd04.prod.outlook.com (2603:1096:400:465::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 05:45:12 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:45:12 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2 2/2] exfat: do not zeroed the extended part
Thread-Topic: [PATCH v2 2/2] exfat: do not zeroed the extended part
Thread-Index: AdmpYxJaQT0eJpq9S2qk9+xpIeN52QlBj12AADN9dEA=
Date:   Tue, 15 Aug 2023 05:45:12 +0000
Message-ID: <PUZPR04MB631640E27834800E8AF620E48114A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB6316007DA330B551F70F08598124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd-bsJYyUi-57_SZbKsZOFwAxLE_qZT2mijj2=NX5ui82w@mail.gmail.com>
In-Reply-To: <CAKYAXd-bsJYyUi-57_SZbKsZOFwAxLE_qZT2mijj2=NX5ui82w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB7129:EE_
x-ms-office365-filtering-correlation-id: 940aa211-2b27-427f-485d-08db9d52cb0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSdeDfRj58iBd5qZLxMr5UpJ4XyfN0yqRhoWsdtg+Jf/yZZB4qOaDi3ZjIk6AX2OK8BYP6HyFUkdcEaoPQpvOf+TWvbkkH1wGoyRiggNbyTGWlZVJFOTnvn1OeMhhZtcJLRIRZm/AoOXAFo6xcUnm0TS3+9x2Eju0U6O9YnFAWMLVSZFsrXn6woLOFOfHwey6jDhcBEMVY6VoWI2Nn0b+Dk4Wuk2hKOmtTPw+Q11j0QRS/CNA8vGa3CFJB1wCoHNxAJHokxrw3jC/vsGYPNvy8/h1LQlEAIpJiILwJ5jn5PjnzJxBCxwQw+jnBl8Gjq6GPq5pm9ozX9cyMT92D55sbR4d3XegQigXbvcdBA9BgtBrLQzyhN31bfql71+Dbp6Xs07RgBYzMHlYETirDwLAPV83aHF+tIrGpN/4O6EZK9DjnQA5LRV8ZE5ChM7E+Kw/GAD7Uzvs4VhiO/fjb1gW0uPcsTY6kJwpGd4GuHaEfHSmKI6rMB0QAlh7FafxyBZ5JmR93S6HIaPEKuKW2lYzU46lx30L8EF03tEgFZxHB2Nq/G1693fGz3AGHKTLRlkFT3tPdyeLsakze8xjsb6ObAoQEb3Rg7EofzKa9Y7Hwa7c1+aiMIQedPDeON+cmrD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(186006)(451199021)(1800799006)(83380400001)(122000001)(2906002)(38070700005)(38100700002)(55016003)(82960400001)(7696005)(6506007)(316002)(86362001)(53546011)(41300700001)(6916009)(66476007)(71200400001)(66446008)(66946007)(76116006)(54906003)(64756008)(66556008)(8676002)(4326008)(9686003)(8936002)(478600001)(33656002)(107886003)(52536014)(5660300002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xMZDRIckVXbEhGVUQzU3lPeWhxMVRVOXQxWkhLYmxIRjRpZHJQZFBHYU42?=
 =?utf-8?B?WlJEOEJrb3NDNWEzZEZ2Z2hUMXQzLzRWRWx3a3c0SldrTnZXejdVcEMyKzIr?=
 =?utf-8?B?NGE2RERaSCtkb3B0OGFnNWxFSmdvRHRPdXhyUTl3dHRzQ2cyRTFYMEttZTVo?=
 =?utf-8?B?V0tVUmhQSitPWEg0MHJNenVQcnV4MWtmM0ZwTmJpSGxwNHFJY29PNkNkV3RD?=
 =?utf-8?B?aWFxcmNPbzNuZjdIcThoNTZhbWZ6bnFhN0djYjYwNHBCRWNQdm1vWEY2aFA4?=
 =?utf-8?B?TWNZeEd1eG9tRnF6aUErU01hN2hFNnRDc3lvRiswUnlRMDhwa01OcGNPbTl3?=
 =?utf-8?B?LzJNWHNlNUFlQjhXdjJ5WTJtbm5MOXRuN05ubWNUNENmU05PdWtZTGpKR2Jx?=
 =?utf-8?B?UlJZVFFHdC9EQ1krZlZnUURNdkZaU05URmR0TVM0UkIvcnNwQ0tZNU8vMmVi?=
 =?utf-8?B?N2FkSFJXWjRrTC8ra1hTZXpuc2Npek8vVWpSNStOMTliWDI3NDNXNXBCU0Fp?=
 =?utf-8?B?cUljZWszRUxqWVQ1TGZ2cW1YcWhOTmx5bFMxSVhuZVRaSGZyR3FjTWZ2MmxK?=
 =?utf-8?B?L1RvUmVqUTRCOHFtQnllZ1ZTZnFjWklrenY5NmxBVzYwd09seXg0UjRVT2NI?=
 =?utf-8?B?NFZZQ3I4Mjl6Q0hmUzVGR0tiYjN0a0h1MHdrTGt5d3J4cjJJekU2cW1uR055?=
 =?utf-8?B?UGVpYzQzWkdFNWFyTkRVcEFWNHdrdEF0NlBsSlJTdGJvNVJZbXdtZlNXV0Ru?=
 =?utf-8?B?d21pdUJrWjJYSkttQ2hnSENkMURseFpOYzdhamprTEhhS3prb21DT3NXZFdy?=
 =?utf-8?B?U0NaQ1IxSW95SU5MMC9yTndIT3pTSkYzdkJ0UmtHeGg0U01tK0JrV00rRlBz?=
 =?utf-8?B?UVRqeUVxWmwraURpTFFlcktoOTVEUFBTNWtRRVJNU3ExSVc5eG9FUlpBOTlp?=
 =?utf-8?B?by9iNXJvaW5GOVkyek5UR2N3Yndwb0VMK3p6QnhBRzNsbkZqVEJTRit1UlFm?=
 =?utf-8?B?SG43a0pYWitObDErcHpidXFnTXVUWmlHcGh2QjdkVG91K09QR015VGtDdUJR?=
 =?utf-8?B?WkNrbWk1em1ZZEdRS0pUV2dJb04wMVlvalYxZVdzcnVPakhpV2R4R2tlQ0FT?=
 =?utf-8?B?bTlianpMYUpCVGxwdkp6OG1lTlQrUWJIZmZpRzZvVHJLRTNJMjJhaEVHRjRp?=
 =?utf-8?B?cW1hTHJ0VDRNRlcrN0FPRjYvb2NNM1R1aHpqcGdudW9GVGM3bjVsN3RLTDhj?=
 =?utf-8?B?Vjh2NWhlUllqMGJkMTByREgxVlQyQ2J6YTRvb3RwTWJqV0tUaEc3TkJuSno3?=
 =?utf-8?B?U3NKdm1oaXFad0RoZnBUQndXQ0hIMXdEYThRY3JRQU1JSWhIRHR6QmFocVFX?=
 =?utf-8?B?L2RSRFRybnpqc2RnemNIdVJxVVRqRnBQSmNINWo2dGdpMVVTdjIzK0M1TUth?=
 =?utf-8?B?NVRDUFZ5UXVXVWRXeTcvbXZKVVM0YUpVMS9wU1grWlpxcjlFbG9DYmEzd0Rh?=
 =?utf-8?B?Mlh5VnVxc2x2QWl3bHN4WkQveWJsYjZLQXpmSnVKYStXRjdzS1FBSzh0aU9u?=
 =?utf-8?B?MDVwRGxmZGI3b2tGdGtZYUkvQjdLbXdlY2JPWFQ5Rnd4VExHeThiZmFmWkRT?=
 =?utf-8?B?M1M1Wlg0aTFEUnpDWGs1VTVuamFvdFFINlRQd2wwd2NjeEFjdWQ2U1M5clpx?=
 =?utf-8?B?N1VONFArVXJleUc2bWcvNS9lck5XcXVEcmZSbDFqdlI3aGpid0hRUFpRZ1o3?=
 =?utf-8?B?NS8xYTlFelBUWmFoREwzSHphb1BMRUxIR3I3bmxIOERnMzk0ajJ3RFRsbEhv?=
 =?utf-8?B?My9xNWFkSDd5eUh3RVRCZEl4bkFySzJQTzdaNkNnUGdFZExQMTd0YzIxbGQ5?=
 =?utf-8?B?WTRrOWIxc1pUZWlhLy9yN00zc3R0Tk9PajhvSVhkQVc4K0duZk5jaDUxQjM1?=
 =?utf-8?B?RE80OWIrajA5dmZsS3BhT01wL3Vwa2ppckszUm1uVnl6TSsvZXN4NUlDM1V3?=
 =?utf-8?B?Nk5XSDlOb3NHdi9LS1YxR2hLTVlmUlZHcHZpaWYwTmVDMDAwS3ZwQkYzTTFN?=
 =?utf-8?B?Ujg4S2VHZ0NjNWhTZC90R1FrSm9POFdrY2Jyci9waVl3eTlnNWhiNzVyZFNE?=
 =?utf-8?Q?fCHrg62pXxd279Ml+I1gBfhvY?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P6t2kkRVJbatBtWJ4omwmSIrkW8xY2WGydU/02gy93C5xZJ0N2tRdKbESBqXuca2qNbvx6gO1sb6dgMa3IEFshSzds/glEOPhRp9CDrUOCQZanb4qIZDDFXSv1uatV2JaBgznaD0KanITiENdv8Fb3wmaIAA4OrmxhlERm00EGLObUYRKSb//AIai5OYbYTt+dJmZ+CKdUxeXkfe7bTWiA49bprBN57SAnebiLcss1aqlHM5ZSpYsr4jnvZGqa75FQoLr/u0kgJezWzfgJ/alOCY1GSvQHdY1o51fDcLamxKOlc7nVLvjQC4jmoa+tsILl9ZUTA0mQVmpm94B9QNZTjc93KQcxUtq+tRJbkM+b6RLbaTmGG7hOw8mV9PAQiqZRYFIpLaVFL6iZ3jWEIj4Aj0ATRY444/rHckh23OEd5/acLaA52iwPmGoIstAWgQmvFwvSPGI99OJvf0eeqq9h6Ab1E9WdZUWkrYLchZOkSK+yVDLPj0ILEpN7tvuTeK1Z5EoYyhNqxCl6t7w9WzT63zCj//SdTG+aPkMqGaRMc89pHJfj3H93ddgo32bFu1LynMcuCWLow/cLiTpjknF1CmCe5dUcHyRs9m1B3klg3mFN2a/W0JEzk895TiyYdLzo0W8RDuUcHHunw7v+TBK5yV+sRk0Kw3EMYk9DHJ0gk8cehTlrgBFTvh8h/aEoQWh530EgT55NX1zMQpubzU8tRY26i8XxABkwZ//rx/bBTAmyq+BTeqVRtgflUtWKvF+EkPiudncJ8sBBprKqSk40cyOmFaTRPkzxIQRYT6A7WeCMT3XWqDoxUsE5tNR59VCdL7EhOAsUOcSKDRDmyYUA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940aa211-2b27-427f-485d-08db9d52cb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 05:45:12.2051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ftzwS492TEWM+PO3WR6SlkpssFCGW71GI3RdqGkwoLLu2CbKTXpx4p2AQ0OfOYeIdxwVwXctBEcQHJniKDrIDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7129
X-Proofpoint-GUID: 9IsDDzMrGsMXmTHPQh-famkfvQvyCgqu
X-Proofpoint-ORIG-GUID: 9IsDDzMrGsMXmTHPQh-famkfvQvyCgqu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 9IsDDzMrGsMXmTHPQh-famkfvQvyCgqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_04,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2lu
amVvbkBrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNCwgMjAyMyAxMjozOSBQ
TQ0KPiBUbzogTW8sIFl1ZXpoYW5nIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCj4gQ2M6IHNqMTU1
Ny5zZW9Ac2Ftc3VuZy5jb207IGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnOyBXdSwgQW5k
eQ0KPiA8QW5keS5XdUBzb255LmNvbT47IEFveWFtYSwgV2F0YXJ1IChTR0MpIDxXYXRhcnUuQW95
YW1hQHNvbnkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gZXhmYXQ6IGRvIG5v
dCB6ZXJvZWQgdGhlIGV4dGVuZGVkIHBhcnQNCj4gDQo+IFtzbmlwXQ0KPiA+ICtzdGF0aWMgaW50
IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKSB7DQo+
ID4gKwlpZiAobWFwcGluZ193cml0YWJseV9tYXBwZWQoaW5vZGUtPmlfbWFwcGluZykpDQo+IENv
dWxkIHlvdSBlbGFib3JhdGUgd2h5IG1hcHBpbmdfd3JpdGFibHlfbWFwcGVkIGlzIHVzZWQgaGVy
ZSBpbnN0ZWFkIG9mDQo+IGNvbXBhcmluZyBuZXcgc2l6ZSBhbmQgb2xkIHNpemUgPw0KPiANCj4g
VGhhbmtzLg0KPiA+ICsJCXJldHVybiBleGZhdF9leHBhbmRfYW5kX3plcm8oaW5vZGUsIHNpemUp
Ow0KPiA+ICsNCj4gPiArCXJldHVybiBleGZhdF9leHBhbmQoaW5vZGUsIHNpemUpOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICBzdGF0aWMgYm9vbCBleGZhdF9hbGxvd19zZXRfdGltZShzdHJ1Y3QgZXhm
YXRfc2JfaW5mbyAqc2JpLCBzdHJ1Y3QNCj4gPiBpbm9kZQ0KPiA+ICppbm9kZSkNCj4gPiAgew0K
PiA+ICAJbW9kZV90IGFsbG93X3V0aW1lID0gc2JpLT5vcHRpb25zLmFsbG93X3V0aW1lOw0KPiA+
IC0tDQo+ID4gMi4yNS4xDQo+ID4NCj4gPg0KDQpJbiB0aGUgZm9sbG93aW5nIGNhc2UsIHNpbmNl
IGV4ZmF0X2ZpbGVfd3JpdGVfaXRlcigpIGlzIG5vdCBjYWxsZWQuIElmIHdpdGhvdXQNCm1hcHBp
bmdfd3JpdGFibHlfbWFwcGVkKCkgYW5kIHJlbW92ZSBleGZhdF9leHBhbmRfYW5kX3plcm8oKSwN
Ci0+dmFsaWRfc2l6ZSBpcyBub3QgZml4dXAgdG8gdGhlIHdyaXR0ZW4gc2l6ZS4NCg0KKyBybSAt
ZnIgL21udC90ZXN0L3Rlc3RmaWxlDQorIHhmc19pbyAtdCAtZiAtYyAndHJ1bmNhdGUgNTEyMScg
LWMgJ21tYXAgLXJ3IDAgNTEyMScgLWMgJ3RydW5jYXRlIDIwNDcnIC1jICd0cnVuY2F0ZSA1MTIx
JyAtYyAnbXdyaXRlIC1TIDB4NTkgMjA0NyAzMDcxJyAtYyBjbG9zZSAvbW50L3Rlc3QvdGVzdGZp
bGUNCisgdW1vdW50IC9tbnQvdGVzdA0KKyBmc2NrLmV4ZmF0IC9kZXYvc2RjMQ0KZXhmYXRwcm9n
cyB2ZXJzaW9uIDogMS4yLjENCkVSUk9SOiAvdGVzdGZpbGU6IHZhbGlkIHNpemUgNTYzMiBncmVh
dGVyIHRoYW4gc2l6ZSA1MTIxIGF0IDB4NTI4YmEwLiBGaXggKHkvTik/IG4NCi9kZXYvc2RjMTog
Y29ycnVwdGVkLiBkaXJlY3RvcmllcyA1OCwgZmlsZXMgNDI2MQ0KL2Rldi9zZGMxOiBmaWxlcyBj
b3JydXB0ZWQgMSwgZmlsZXMgZml4ZWQgMA0KDQpJZiBtb3ZpbmcgZml4dXAgLT52YWxpZF9zaXpl
IGludG8gX19leGZhdF93cml0ZV9pbm9kZSgpLCBtYXliZSB3ZSBjYW4gcmVtb3ZlIGV4ZmF0X2V4
cGFuZF9hbmRfemVybygpLg0KDQotLS0gYS9mcy9leGZhdC9pbm9kZS5jDQorKysgYi9mcy9leGZh
dC9pbm9kZS5jDQpAQCAtNzIsNiArNzIsOSBAQCBpbnQgX19leGZhdF93cml0ZV9pbm9kZShzdHJ1
Y3QgaW5vZGUgKmlub2RlLCBpbnQgc3luYykNCiAgICAgICAgaWYgKGVpLT5zdGFydF9jbHUgPT0g
RVhGQVRfRU9GX0NMVVNURVIpDQogICAgICAgICAgICAgICAgb25fZGlza19zaXplID0gMDsNCg0K
KyAgICAgICBpZiAob25fZGlza19zaXplIDwgZWktPnZhbGlkX3NpemUpDQorICAgICAgICAgICAg
ICAgZWktPnZhbGlkX3NpemUgPSBpX3NpemVfcmVhZChpbm9kZSk7DQorDQogICAgICAgIGVwMi0+
ZGVudHJ5LnN0cmVhbS52YWxpZF9zaXplID0gY3B1X3RvX2xlNjQoZWktPnZhbGlkX3NpemUpOw0K
ICAgICAgICBlcDItPmRlbnRyeS5zdHJlYW0uc2l6ZSA9IGNwdV90b19sZTY0KG9uX2Rpc2tfc2l6
ZSk7DQogICAgICAgIGlmIChvbl9kaXNrX3NpemUpIHsNCg0KSWYgZml4dXAgLT52YWxpZF9zaXpl
IGluIF9fZXhmYXRfd3JpdGVfaW5vZGUoKSwgaXQgaXMgbm90IG9ubHkgZm9yIGFib3ZlIGNhc2Uu
DQpEbyB5b3UgdGhpbmsgZml4dXAgLT52YWxpZF9zaXplIGluIF9fZXhmYXRfd3JpdGVfaW5vZGUo
KSBpcyBhY2NlcHRhYmxlPw0K
