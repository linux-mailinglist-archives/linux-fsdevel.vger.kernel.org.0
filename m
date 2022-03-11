Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D82D4D59A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 05:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbiCKEfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Mar 2022 23:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346312AbiCKEfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Mar 2022 23:35:47 -0500
Received: from mx04.melco.co.jp (mx04.melco.co.jp [192.218.140.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96EDC3340;
        Thu, 10 Mar 2022 20:34:44 -0800 (PST)
Received: from mr04.melco.co.jp (mr04 [133.141.98.166])
        by mx04.melco.co.jp (Postfix) with ESMTP id 4KFCl74y0hzMwSrY;
        Fri, 11 Mar 2022 13:34:43 +0900 (JST)
Received: from mr04.melco.co.jp (unknown [127.0.0.1])
        by mr04.imss (Postfix) with ESMTP id 4KFCl74YFtzMxqdR;
        Fri, 11 Mar 2022 13:34:43 +0900 (JST)
Received: from mf04_second.melco.co.jp (unknown [192.168.20.184])
        by mr04.melco.co.jp (Postfix) with ESMTP id 4KFCl74DcjzMxqcp;
        Fri, 11 Mar 2022 13:34:43 +0900 (JST)
Received: from mf04.melco.co.jp (unknown [133.141.98.184])
        by mf04_second.melco.co.jp (Postfix) with ESMTP id 4KFCl74BMczMr4p5;
        Fri, 11 Mar 2022 13:34:43 +0900 (JST)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (unknown [104.47.23.176])
        by mf04.melco.co.jp (Postfix) with ESMTP id 4KFCl744PjzMr4pc;
        Fri, 11 Mar 2022 13:34:43 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkGoFpzBhO1gdFkeQCoycFsR0u5at3ccCduDa+9imd9d5Be30l6X1NG9ulJJLreb7B1ChKskKT/cNQnTKEkmrsyD0z8HI1q8KpiQLB9qHHWmfK1SvmbUgIhVOW4cHNUcXrKGqy0W7ZO4wJwJOuOKsjbIQ1lSazLau3SdvVskN7qsY6tZ0OwUFMJmQI+ZLcGYW99Lzp8VP+4pFbjmIysR1YCKar39hn+DENuygVR5a3KU2af3qaTyGNwOiQD8F8pA6i+Ot8vd+1yNMz9yvWS+A1SM4ZmzDmuShbL+O1rt33mSdeyBqnil2jvtrQxBMTxUVTJAuuJl2kFfEaS5dP4EGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCX6Ee7v06L9b6q+CFiXEW0yswm7gutDJVkk6WSWl0I=;
 b=hV6JK5PoKG5qa4LABkvB5Y6Jy2xcnQs+gJwXPc7y8W3PrxpLJkxaK7qPeLulG9jCEv8aEZAphSd8wVJWVcBkUcio7zG8ccpXmftZQo9vAoSrPwtkww/mgveeLPuQ5Z+l4Ko9iZiWtR4UlhI4HtrcbV/reufKqFI5ZYaR4nJrXEx8ycIDpkFd4kyKcZJ/xZFNqsMwUM9Fc8XGDcZopQqL/dpdd2DaskuLQakIXJ3ICXlrlAUyl1hURYlWn0sWhCHKNHjp9nngqmBkQhiB5uTlp9ZR1aQqtWd9EiHNEW3y5ZUJ/jpbxyhJsUrAebU/HuC2j1WTrECX4NX1eKbTNmqPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCX6Ee7v06L9b6q+CFiXEW0yswm7gutDJVkk6WSWl0I=;
 b=TnDChcQtDmhXg/N3/PxQ51d94xjm69/hpo+HCTk2JOFf6ilDY/pxn6Q62ILp0C1ssxe7W0EkaFbk/a4aeTd8Qh4ky49FFaa9pKdJrjZBoX7rXlMLYVbb7ZkCSXdjiOzimMFWxPDeAJiKxyYfI3wqKkEfSbAye3eFDcPz85SKxys=
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com (2603:1096:404:803d::8)
 by TYCPR01MB9304.jpnprd01.prod.outlook.com (2603:1096:400:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 04:34:42 +0000
Received: from TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818]) by TYAPR01MB5353.jpnprd01.prod.outlook.com
 ([fe80::cd6:cd27:1fe8:818%7]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 04:34:42 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: Re: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH v2] exfat: do not clear VolumeDirty in writeback
Thread-Index: Adg0Vskc+T+8E+65Sm+jIEZBsmb4mgAqgpIB
Date:   Fri, 11 Mar 2022 04:34:42 +0000
Message-ID: <TYAPR01MB5353A452BE48880A1D4778B5900C9@TYAPR01MB5353.jpnprd01.prod.outlook.com>
References: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
In-Reply-To: <HK2PR04MB3891D1D0AFAD9CA98B67706B810B9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e1146c54-436e-ead6-9b8d-ab4a661713dc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dc.MitsubishiElectric.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b092e84f-6133-424f-58c3-08da03187621
x-ms-traffictypediagnostic: TYCPR01MB9304:EE_
x-microsoft-antispam-prvs: <TYCPR01MB93043EF7A615F8E864DFECB2900C9@TYCPR01MB9304.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bIBhtaRBeQT0DomnS/jvVwZJBTNpmUqnQ77pGOUBhdd7ZRY7wft8NrDHDdkQwI6fOQK7IV0zVRj8FIyulOZ7u08eQ8GoCRM+e2d8NzmyjIw45kHjWUDtioVqTzOgV+7LPnHm/NDn8zjqx3kOLkGfDhMqd59VGDpCmr/XIi4P0En01S4p9goUFwllgT8okMSeITrG1RU6xY1zRaRktV2ECpk4dk9u5IEtd98S3KTr92zb7yRjHQxLCN/gRMIeBJZjDjeykC7PAn8zfSe1Yxm2R+J9QWjH1I+7iDfzL0USzkOeAtvTEKWgusjej3vV/GN5PBrXTaNi9HPnal/f4wtflZiQciJEXPH+nx3H6ubUTUXbQmgP4uG4r8/y2nTREnZc4nppFnXXSHf+dXwNk0qlW/lSfNFAeMtDIRrtC9wUDBm8GNY3w32+NL9Z+PXgVM5iiS8y5o0DAtIkLnjRwizbxsNIQxIgTzOWPDJ9PPRowCWjXUNSpfe/surYKMbQeXeVBWFNv1ZEPifKJpKokVOjt8ZEdFzU72paJkvX3955PqlOiFWjYbGrN7uqevoccZkOMXsyfs0+Cxe7yA3y2MFeRq5gTFKB3k3xRycYm6Dcf5K/0ssrZ9wtnyvfYM3OYReaDPVNlcPzX4A3bmlio9eup5nYqDtojZilN88PTVBDAP2tG+th8Ac2rVD1UkQ2ii7Op0oi7WZm2GRTCrdwdZjbpacoRR84BfP1jcM4LP7gc3CJ2o304w504BqkMz/9g5q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB5353.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(2906002)(508600001)(38100700002)(122000001)(66476007)(4744005)(33656002)(186003)(66556008)(71200400001)(7696005)(8936002)(6506007)(86362001)(316002)(83380400001)(38070700005)(55016003)(5660300002)(91956017)(54906003)(110136005)(66946007)(76116006)(4326008)(9686003)(64756008)(52536014)(66446008)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b1dkU09vaW13N1U3ZlBYU3lGSis2eTJ6aUkyOXcrRnptYm1UUkVRa3Fy?=
 =?iso-2022-jp?B?Q05pbXczczA4UkdUQkdBY1ZaRkRLQTdGZnRuTnk1VktveHN5LzVHcmlh?=
 =?iso-2022-jp?B?Smtwa2c4YmRzeTJDZGV0eEFmUStheUlPR2trd1FmSyswUkIwejV2Nkp4?=
 =?iso-2022-jp?B?UmJ5T2tzVXVnTzByenZlZkRweUhOaENEbzdLSFhvRW1mUGRVY3MvblE1?=
 =?iso-2022-jp?B?cVI5dkRZYUhYL2psZXdwMlFvdkVmN2wvZmNUM0YwRjlpTU1xOUNLZ1la?=
 =?iso-2022-jp?B?ZkhKL1Q4TXBXSFgvM2FZbXl6dEpwK0IrMkcrY1J0czlGMzN2dEZyUHlp?=
 =?iso-2022-jp?B?akcvWXQrcVV6WmZ2NmxzUGk1SWxUMEIzWWNScmtiTHBGMStOY1M1dlgy?=
 =?iso-2022-jp?B?UVBPbGEyUTJUVDhFbWhVWHNPOUNWQzlIZGIwdDNObmhSWmNmTXN3aitD?=
 =?iso-2022-jp?B?aHFOZ2lsY21rU1hxTUEza0RpYVFrQU9pSDM5MnduVFNjUkNiaEpWY3lC?=
 =?iso-2022-jp?B?OWc1OVpUMkR4RDUyekh1bjViYUFsa0hYWGNwSkhlMWxQMHZCZjlTTkQw?=
 =?iso-2022-jp?B?eldOUjVBUk8vRnROWDZoWWlDby8vUGVvOWUxZ2UzY0NUamU5Ylc5Y2ZB?=
 =?iso-2022-jp?B?ZDZTVHlOWFBzNEpRTTdvNEoxQ2FhMU1Zc05BWEp4ZmxxMm5QdEdSZkhp?=
 =?iso-2022-jp?B?bTBGanNvQk5kaUhBSWRoOXpOTlRaVEVCTWxCQ1prQ3I0andlQ0VqeXF4?=
 =?iso-2022-jp?B?L1FHQ2lkZWhJYXFHeW1qclBvNitoVFRzV2kvZGtLUWRKRXF6WDljOVJU?=
 =?iso-2022-jp?B?Y1lnSHZicXF3Sm9UY3RWREI3TG13SW12K2tLL2VJZEk0QjNodlNHY1RD?=
 =?iso-2022-jp?B?T0hLdFJ5MTh1cXlZcHlaLytQeThpaFZtVUJPNE5yRWF2T01QZUpvU0RZ?=
 =?iso-2022-jp?B?YnRpazlmN3pVQTR0ak1YK1BBRjRBQXFrVFpmMW9QY3VVMHBRZklKRm1M?=
 =?iso-2022-jp?B?WmN5ZkNpd1Znb0hoRVZSWTc0M0cyTUkyRTFXVW1LeDZLc3NLRGZvYUxT?=
 =?iso-2022-jp?B?STYwTFBzWFdSR1BCdkVObnRiNjJpd29WTzFUNHdDcnBET2MyZnJYOUlD?=
 =?iso-2022-jp?B?WlhQaXl3TUhVcC9zMDRzQlJybkx1RjlNYmpOb0FmSWJqRnYycVl6eGVs?=
 =?iso-2022-jp?B?ZG5TeE5TbitFUlVoTS9yaWdKaU0zVG95bElGY2dTdWw2YXBhT1ozTHcv?=
 =?iso-2022-jp?B?QysyamVyQTA0VnRzK2lVUFhIRW1ZSEhWdWxNTnJyNE5HN2VKWExXdy8y?=
 =?iso-2022-jp?B?Y3Z6a1h6NlBGWFNVS0MzcGZPU1YvQ01JdHRuU21vdWlsZFc0cmdlT0ln?=
 =?iso-2022-jp?B?NEpIVlNqZkVuTkhQRkY5VVRYampRbE83OWhiL1BKN3Y3d2kzNzY3RTQx?=
 =?iso-2022-jp?B?RE9VcVhtakNoZUZhd281MW5DOGJsSGZ1K1dJNmVzcytoQ1BZMXUrMG5M?=
 =?iso-2022-jp?B?N0tDN0xYM0s2b1NZTDNyd3VjbmNQZ1p3aVJnTE1pSjBlSy9vZ2FEa0xM?=
 =?iso-2022-jp?B?cG5pK1Q4dk5oN3Jtbkl6YXlVN3ZXSmZlR1BOZ3B1R3lUa2hieGJhMFBt?=
 =?iso-2022-jp?B?d2wwck1TQnFveXkyZzE3cG5ZNkpvaDhqQTl1eU1nODVJbUZjMktjaTBS?=
 =?iso-2022-jp?B?aU4zMmRCRzhYUElya2tRTGFuQzlpbXl2cmg1U1N4TFpJNUZjaGQ2NUxi?=
 =?iso-2022-jp?B?VkVIZ3hBaGJCV3RRYmZQbHQza3hWMld2YjdneWtVQy8xSFRiUEUvc0kv?=
 =?iso-2022-jp?B?WUhybWtwMUpSSnhnY2NvcWpOdGRabkx4MnZkaHBCaWgwRFdYWG85REJv?=
 =?iso-2022-jp?B?bjR0MmNtTnRQUU9xbGRDNHNKVUxXNEdSU3MzYVBXMXd6L1Yrd3FRalFK?=
 =?iso-2022-jp?B?UFRFQnVwNWVLaXZWaVhwOXRiRG1ocnFwMVZjUkpwQ1BGMCtVV2NjZUhW?=
 =?iso-2022-jp?B?VjRZTWl1WGc1d0RLNzFWSitrOUJHdUl5eStjSUVSRlBpK3JiYnZIZm1j?=
 =?iso-2022-jp?B?V3N5ci9DMFllOFM0djNjaWpPaGxvUnZ0WXdVOFZXWll3YVZjTDdCK0ZC?=
 =?iso-2022-jp?B?amhOSnBrRXozZkxuNWlLTDYvRWFSZ0diUnVqY2FqaFBjbnQzcTI1TFRi?=
 =?iso-2022-jp?B?cVh5QVdwbzhYbXhiVjl2Qk5rR1E0N3Rlc1hsUXMxSm5BTERhUUxUaVRy?=
 =?iso-2022-jp?B?NkV5NjZmenY2bENxT2tBMitPMmkvMFYvbnc2ZE03SEpFUFJhRG5DK25C?=
 =?iso-2022-jp?B?c1M3c2NhM3dka0M4OEd1ejVvamFaL1F3RXRBKzExdGtXNVVMZkFRcEVZ?=
 =?iso-2022-jp?B?UDdkYjl5c05Ya3JHaUsyaHV5T3dZTHVadWFkWmRkMGF6MTZObTYyV2Fv?=
 =?iso-2022-jp?B?WW40cEg1eFhabVVVMnBHbDVvNzM3Y0NwMktrPQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB5353.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b092e84f-6133-424f-58c3-08da03187621
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 04:34:42.1873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irC51PxVjAUlpZYIS3j2WCpZybZIWAPssI7zR94jgMJqGpoPSpD8keS9MRVcBXMItymzdNySfkPep2UUA0f3Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9304
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Yuezhang,Mo=0A=
=0A=
I think it's good.=0A=
It will not be possible to clear dirty automatically, but I think device li=
fe and reliable integrity are more important.=0A=
=0A=
=0A=
> -       if (sync)=0A=
> -               sync_dirty_buffer(sbi->boot_bh);=0A=
> +       sync_dirty_buffer(sbi->boot_bh);=0A=
> +=0A=
=0A=
Use __sync_dirty_buffer() with REQ_FUA/REQ_PREFLUSH instead to guarantee a =
strict write order (including devices).=0A=
=0A=
BR=0A=
T .Kohada=
