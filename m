Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59FF51531E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379848AbiD2SE7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 14:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiD2SE6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 14:04:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA15B8BE26;
        Fri, 29 Apr 2022 11:01:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TGTR6n025808;
        Fri, 29 Apr 2022 18:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=F9cBkwDcjp2IlkH1mXUAwwSMQAER07d1ZVVLK/lnYEQ=;
 b=q8OI1IA+o2tVw4CMackd7oDV/V+IkS3IXCSaRRmhQddawRrgfKtqEkVyJAYFGUGoIRQb
 gsyzVq5Sco1Fd8H3+UWKYJrilf6fbkXIWDrV593DVep6gS7p3rUalkJ12br0KY8Fn/sP
 S3b1MdstE2nnhWouP1XtkWHa0Bj7c5m/wCdAXM51sqMcTuOG/O4ZtqPwjapRYrx7LD/7
 GK+7M1Pq0OA+OnyGv8MWWzePg0PpnuMg8fEVXPClvc8SxqNVdSTdbNymCh2nOkljUZoV
 Y77OqBcFCDwh4wWOn5ZI0BBc5ZMQna9SrKQ1orsKQGtGNZF7huaERAnutM0KUkjExMiq Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1myjwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 18:01:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23TI1FxV035726;
        Fri, 29 Apr 2022 18:01:33 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w8bbab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 18:01:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caSb0RNXXzqvF940byaWwgL2WVLEQILE7qNpcUzTdQuUex148CKGQZ6LDJrCMxs48B6I3qPmk8hQioJj49Yinjt3h0pEaR7eg/quI1+zM/KZyZSB2plrfnidbce/65jBQKIGGf+DV+5nHEA+t0iEMDizTTu2PGr4ZxCH1eS52qcGSmLW+uAAmP/3xB1IWKUeWiE6NRqi+Ff1aD1yHVaV6CL2MWTB3Yo4cp0AR38MXuSFYu9z9W+p+SGM7cbvHZLpFlk8i3plmlRbcPRhQLfH/nlxDf2+bcgWMNgip/LMpswwZTTm7s3TPF/tC5e6XRUDE46aedK/MpHGn8NxMQ/Dgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9cBkwDcjp2IlkH1mXUAwwSMQAER07d1ZVVLK/lnYEQ=;
 b=QFeNb+CH+ZEmgyaaUQ2txhHE0KWLf56x6sSrQDyVt/ysyNcMgllfrWPcn3sACfPl5xgdDy786d6NX/paUR8u+cXT6drzH2pJBZLX/+axwQ1YlIE+HgGc3kaBorYUQU3T+ZpVGaVzCibRuB9cp3nqdY5mhYOaQAxmL2tNbeuBc/hus+Qr9LN/7ngw8oNbAtkT9XIwpDkJ7wfHIZhPW39A6JCqvtjDFSKiQmbaRu/BChQnzr5hC7U7fX6YoOGdJQxeu+AI9DOLLD6C/lHma+9xJlwOJZzuYRmZfpfMqm0qA2+wUvCRYuvnHBZeoraOgZ6sMG5a6otK3ORLpjB6IPK1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9cBkwDcjp2IlkH1mXUAwwSMQAER07d1ZVVLK/lnYEQ=;
 b=govUNeW/t+Wmc0Z10snOo8JfsueRXYSaNe8EAsPlj/7FG0P4ztJZYwKI1j9qjamsWSzgKspwnJ7OoKu6NumBuYHMbKxPwGwcFef1FhiA9OjEZc1OSQzyMoqrhpJBsHPJ4UpnY8JiSFbn+LCI+lb65wTLOQq3YSh47/ejEl0bg9g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4182.namprd10.prod.outlook.com (2603:10b6:610:7a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 18:01:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 18:01:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     syzbot <syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [syzbot] WARNING: suspicious RCU usage in mas_walk
Thread-Topic: [syzbot] WARNING: suspicious RCU usage in mas_walk
Thread-Index: AQHYW8FgbE7YB0W0IEuZQIyo80FrLq0HLsOA
Date:   Fri, 29 Apr 2022 18:01:30 +0000
Message-ID: <20220429180123.fojd3kxpprqdzkgu@revolver>
References: <0000000000006b8dad05ddc47e92@google.com>
 <20220429120456.qcs7qbtv3o4hiiv6@wittgenstein>
In-Reply-To: <20220429120456.qcs7qbtv3o4hiiv6@wittgenstein>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89423a7b-55f4-4fc1-1636-08da2a0a4a2a
x-ms-traffictypediagnostic: CH2PR10MB4182:EE_
x-microsoft-antispam-prvs: <CH2PR10MB41829F3DE806B1CC427DAE2FFDFC9@CH2PR10MB4182.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: llHZVZ47AEDSeYiYguhkFt7E5o9wa/wcQVkw1B5aKhlwzhBVS9BqWfn2nLC9xcOE8auKVBcWCMG1VZtbJPsqKgSjg0M7wyiODD55I0/34xiwBSdZNkJ/Le/i9a2tMSWR71sxJorcuGFK/6Ri+Mfx2jUE0EvngWX/tOLWzlcVzJwhy4RQDqhSQBueOCJpomoJBA3KFLy88A/rYC6wFg5xmTGQbG63At2Wnt0Z4hDoIku3M4TTPY7XK9PVia7lePlIHrM558HYwPI/39U2AR3U2pc/eOtKYaCELd4Ahs8KxJRKmnHrKJ95ik6Iw8pIpvMCcctAkIknBYg+xosVpvxQD4xDK9o2GGZtxAUH2LcsRqLujyZRjFSCQs+PxWAhdheFpJxUN3tQsVqWIUe+vxGkQFe4DMfiVwJyAicoOLvjVQZRLa/MIrRVXJOKFARge2F1XnFlSwKoJwD1UR4R8StqbZILbd3ZylNXEliApoJdkc8vxxoGAcAEb7Hz1ncECUdZYBiBGFm5qQ8KeiFF/VaKzJ5INpUlDXsZ0/oUYZxael5I0AszpmbYgpEcxeiCK2AoHqq79R+N/XYJ73+8jZRBERrwBNqFzRJ9Yr59nvGKcVM19nkStJ3yi4HEoDwGUc7Uk0PtQsrCaVZP4aUxK5d7CC3HZmC0d8ZSTF7jHK5uBnhYcBC1VM2JZ+tcvbrD4wu2nXVJz8UYL1Xyx0d5m6ROwW+T+fJ2TyZgVRNG/07v5HbHdB2lFauIxmTjaawIdsqekh+1WUT8gMSqYKjGWB3V8LmaQJ0bDgqaEV0pCtXGUwcWp0mUzNoP1CwgmMh6PVP6QlY3TvUaIAKVHDQZpT6HHSovsu6H2+y5x6IyDtuC/IQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6512007)(9686003)(26005)(6506007)(1076003)(83380400001)(186003)(8936002)(44832011)(64756008)(8676002)(4326008)(5660300002)(2906002)(33716001)(66476007)(966005)(6486002)(66446008)(86362001)(508600001)(71200400001)(66556008)(76116006)(54906003)(66946007)(91956017)(316002)(6916009)(38100700002)(122000001)(38070700005)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UU51qoUN0gRvyR/co6klNjUrsAAMu/Y7ik2Cdk3BJirWgcqZ4z/SguT8qjse?=
 =?us-ascii?Q?JVvVqOjE5bDJ8udhF2trxfu2mBhkE3yAt0u+X5Y/msIwwfngXdodZUH5FF5a?=
 =?us-ascii?Q?LqOAi+yidRonIyqKmB2qi+6ARJ7Akp0RYQJr3CBUpePfeOqIkzZoHL5V3JKi?=
 =?us-ascii?Q?CwMPQ98lXlRJaC1iVoPjULE9hGrgNISW/DZl1BYZtoWqidkT9YoHkTlJcz4M?=
 =?us-ascii?Q?D9BnsFqLq6a/yykYifraqOQaXnzovv+IWFbwfglDgkvJUErgMGeyCQ5WDPeb?=
 =?us-ascii?Q?TrrKRe8Z8/ZKKny8smwrOg+ergExG130vu7VyBKIh/nxGCHcz6PeLOB1rliX?=
 =?us-ascii?Q?Xth6ugql13iTkhQopi/uKLtOu5GGMrADZdj8MoY84ZmrsyN+39sWK1JKfKyB?=
 =?us-ascii?Q?b9b4TWLkQACRyCJaNzfehOrqi2lX14EHvtfpfAEuGMLpMYbCCZAV+iUhFtNk?=
 =?us-ascii?Q?4yfo0dbkgnlqBmww0Ftpi5JeudNt011KmGFGjMi0aSXuyiwKDaBuAlun8yLQ?=
 =?us-ascii?Q?qYDe42MkyG8yxfQb+5oYEsJ8RPJIIp+IkY28MndvRX/WZlAZp1xi6rCE4rbS?=
 =?us-ascii?Q?UBoipyTyaoMjJkqKzOE68f/Ik4A5ndWZw0GizUw0ZGfNEEkqaDSPTmxTiCst?=
 =?us-ascii?Q?3i2/FyFeyOxW+NfKVJIYSVdk9W61Utno4pTPotqc9yB21ZjcfSjy2YRotkY2?=
 =?us-ascii?Q?TfyiegUIURJDVJ6cadvFT1LR2xa7+6H6K7IkAQgTh2YBhpCKL7G6dmwLIPC4?=
 =?us-ascii?Q?CextDtyF/ud91FZaIMJa5//3dNK2NP7+Z4ZFiA87x/MTCgGlK4W5WXeZgoSG?=
 =?us-ascii?Q?4GZYG45TJnlLaLKwOHJWjry9wU1xf9ibu2P2rQoa6i5lIN34HZQn+WEmppVq?=
 =?us-ascii?Q?iCvrlSsyHUHjQnJi55bdLU9DuqSH7Jvr4e2K5Rd2qixps2e+qE47FGYvolpw?=
 =?us-ascii?Q?lu2WA5qIEB6xxlv8WO4ZrAlnNzVedPliDIhi7SMuJ16xLBnO6vM81SCLDGxl?=
 =?us-ascii?Q?FgSSIvb4280tFORdWQnG7B1hvsyIp2cDBK61v0s/QPxE4wukPAXVdDxNBqJx?=
 =?us-ascii?Q?Bwl06jIyTmHHJEWSPaWOwplL8PUzn1mwCoEBaxg0lTBUZjvIM6jVYAC/DfX3?=
 =?us-ascii?Q?9aURunKJ1iT76JDSOQNKu0t49tVzl43hdDm6LPb6g+mYQ16GoQvrejbJC31P?=
 =?us-ascii?Q?wzEU/4xYOpDYNN0LNPrxJxBk5rBfzwZTbSPP+BGRroMV/k4DEAPUzmRC6w0o?=
 =?us-ascii?Q?aRfj2aCgMPu1jkV3nU7JRLn3lXfaYen9xT+c9crmypay9owFe9252EMnTQMN?=
 =?us-ascii?Q?8EiYqQdU5yjQsmeuak31TZbd4pf1JAV7ofi3aNbbA15TaRwhPmsCZI3QkL8n?=
 =?us-ascii?Q?8ohOHgW2Lsvh9uwrjzAFCzHkOv3HazaeRCo/gIOB9livEzu2y20GthK24yza?=
 =?us-ascii?Q?ckusuL9pa0kr1xNutWuo1jsQDKqqn76J9s0/MCQKihfuEq+srp0a9rKl2JVz?=
 =?us-ascii?Q?sh3tXM1pGXPtUQeW/QmFblgemlq/tuZ5z56HV1yPFj6v5rAaSNtU5IgEwnNu?=
 =?us-ascii?Q?UBZuizLGx4MV8o322fpkzLfSweegd8EkiL81OWDmdiwjifDgkvunIMPo2aTd?=
 =?us-ascii?Q?P4PYxPIuuuxzNkRJSk+PQdvw+SNb93uGSxGZnBOpSckEPFiOYPVZgqdTE16E?=
 =?us-ascii?Q?xju9fbPA18XDJ6iMF7BPO/lXvFUmLXzlLZMO5XGjcKHDOymhsoMHNLaB8Uy3?=
 =?us-ascii?Q?qo2O3C+w134FobVhecNLniaBVa3eRMg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0F42E2E34F3B2142BC1A91AC95EE9851@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89423a7b-55f4-4fc1-1636-08da2a0a4a2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 18:01:30.8189
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LOG+N2kF8Xb3/qwKvXI99fqdDIanA6G6bfQkFXzYIvkRrxOe/320PVX9bIE0SZe9iCV13ucY4lyT+kSpw7CHJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290091
X-Proofpoint-GUID: pDdLvf0hdNoXnE3FBJKxpi8-KhU9gY9z
X-Proofpoint-ORIG-GUID: pDdLvf0hdNoXnE3FBJKxpi8-KhU9gY9z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner <brauner@kernel.org> [220429 08:05]:
> On Thu, Apr 28, 2022 at 10:41:27PM -0700, syzbot wrote:
> > Hello,
> >=20
> > syzbot found the following issue on:
> >=20
> > HEAD commit:    bdc61aad77fa Add linux-next specific files for 20220428
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D15bb3dc2f00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D87767e89da1=
3a759
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2ee18845e89ae=
76342c5
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binu=
tils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1118a5f6f=
00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D125bd212f00=
000
> >=20
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+2ee18845e89ae76342c5@syzkaller.appspotmail.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > WARNING: suspicious RCU usage
> > 5.18.0-rc4-next-20220428-syzkaller #0 Not tainted
> > -----------------------------
> > lib/maple_tree.c:844 suspicious rcu_dereference_check() usage!
>=20
> I _think_ for maple tree stuff you want to somehow ensure that
> Liam Howlett <liam.howlett@oracle.com>
> gets Cced.

Thanks for sending this along.  Yes, it would be best if I was somehow
emailed for maple tree things.  I did add myself to maintainers for this
file.

>=20
> >=20
> > other info that might help us debug this:
> >=20
> >=20
> > rcu_scheduler_active =3D 2, debug_locks =3D 1
> > 5 locks held by syz-executor842/4211:
> >  #0: ffff88807f0ae460 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x127/=
0x250 fs/read_write.c:644
> >  #1: ffff88801df04488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_it=
er+0x28c/0x610 fs/kernfs/file.c:282
> >  #2: ffff8881453b9a00 (kn->active#106){.+.+}-{0:0}, at: kernfs_fop_writ=
e_iter+0x2b0/0x610 fs/kernfs/file.c:283
> >  #3: ffffffff8bedc528 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0xd=
1/0xa60 mm/ksm.c:2917
> >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: mmap_read_loc=
k include/linux/mmap_lock.h:117 [inline]
> >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: unmerge_and_r=
emove_all_rmap_items mm/ksm.c:989 [inline]
> >  #4: ffff88801e5e8fd8 (&mm->mmap_lock#2){++++}-{3:3}, at: run_store+0x2=
a5/0xa60 mm/ksm.c:2923
> >=20
> > stack backtrace:
> > CPU: 0 PID: 4211 Comm: syz-executor842 Not tainted 5.18.0-rc4-next-2022=
0428-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> >  mas_root lib/maple_tree.c:844 [inline]
> >  mas_start lib/maple_tree.c:1331 [inline]
> >  mas_state_walk lib/maple_tree.c:3745 [inline]
> >  mas_walk+0x45e/0x670 lib/maple_tree.c:4923
> >  mas_find+0x442/0xc90 lib/maple_tree.c:5861
> >  vma_find include/linux/mm.h:664 [inline]
> >  vma_next include/linux/mm.h:673 [inline]
> >  unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
> >  run_store+0x2ed/0xa60 mm/ksm.c:2923
> >  kobj_attr_store+0x50/0x80 lib/kobject.c:824
> >  sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
> >  kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:291
> >  call_write_iter include/linux/fs.h:2059 [inline]
> >  new_sync_write+0x38a/0x560 fs/read_write.c:504
> >  vfs_write+0x7c0/0xac0 fs/read_write.c:591
> >  ksys_write+0x127/0x250 fs/read_write.c:644
> >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f6a91306e79
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffddeb8cde8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f6a91306e79
> > RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
> > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
> > R10: 0000000020117000 R11: 0000000000000246 R12: 000000000000cf84
> > R13: 00007ffddeb8cdfc R14: 00007ffddeb8ce10 R15: 00007ffddeb8ce00
> >  </TASK>
> >=20
> >=20
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >=20
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > syzbot can test patches for this issue, for details see:
> > https://goo.gl/tpsmEJ#testing-patches=
