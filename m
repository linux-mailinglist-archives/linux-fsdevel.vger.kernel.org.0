Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A309511EAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiD0PVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 11:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239392AbiD0PVB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:21:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637C43CA4F;
        Wed, 27 Apr 2022 08:17:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23REsc8s015405;
        Wed, 27 Apr 2022 15:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kEvYspeb0Chr4LiQ9yzMPRcbNfqMOuHYeKQmHhLKVkc=;
 b=wjhA38sNX4+lmSaXlOuK0ZIjEzGUkc7EgE5WfPKdRN9HzqdWxLU8cMwDKXsT3OvwUAMX
 OGrx+5C3T8szwtyIixsz4HB+4YQKC0SEZKr0M8+DTgO+ZZekwCZTcmGGEjsYswFdAgHo
 KT9T4z/uq3ZxOaGlwjKQXdlUS+XDT2ZQY4BIW9edoFQATFoml4y7N66TM7GywafIulwi
 Yd3h2c0HhpHD9ErAsC4W20SfxMhANZrEjxD8LSjFs5OjVjbFrAbUt8ph9wwAQcaVX+W+
 ze0IZkKBt873C4BCwqayxyJooTZw99tyRRY9HKwR/2VqBUFg1kvfAylxQP3ndU6ee6+Q Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9asby5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:17:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RFBAY5001544;
        Wed, 27 Apr 2022 15:17:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w4xhm8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 15:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLbL5NWmkY0pv6F1GQIIDiXfdd+fZUPVXIJLol7lbkkSnhE196FN1phV2NABujqjt6lzuTW5g+M3XeaMipiscmcfMcdgVVy1VXZwgMSr/4w5aEyBOYCVOYYJbhGU8zO2VpYBKc0PweQJ4IH3t8RO2QLVP4XZFlKcxF7KL7aFnAiv/e5tFQJXCF1sDOQ2CAKoj428HVsyHk9XWkNmazOaGtEhNIr/dG1iDYFuHkgbaPmXFXagPtRcLiyP5n2h7XFZXAhZKqYLRNVJb1E9jvGuHcfPD5cVicUwcjShZyYht1igE52uhwu19b/gQ43+FYzbjrSfgeZ5cbs+ndE3o7JavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kEvYspeb0Chr4LiQ9yzMPRcbNfqMOuHYeKQmHhLKVkc=;
 b=Z3sx1L3xmoHAyTd7JGwQ6SFdspdGV/64cztEpuNXgH01zXINabMbbKTises8sEy1lvmvjJnn+dxQ2mysu2FOKDMGcGA44XyX8+kwF7TshgpmeyJc2fRfdqQhJ/oFulQZlKvr3SvmcWr7KX0EoRgL1C9l5TLxGB8STU/I7dixtigenr5BIB+EB1zsSWQLSkSG9Q74zVI9Y916jhEK0dxJCZ63TrMk1FLgwA429ZqO/uYB6Ioa0G2WLtMo4lg8Ni3s26gWpXdPZgcrFKwp9RQAnx8hZwuoBWna81SkvpNHIRhty60kiop4l2j1rL0sVRRuKYKXFWhs1OZ9k9A+KOhKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEvYspeb0Chr4LiQ9yzMPRcbNfqMOuHYeKQmHhLKVkc=;
 b=yW/dzNX1gf0tarZkuTtLALAP/xr5AX4DovXoK3ZDSeATJXlsi7RvBLgG4R3vMq++bVV8j4W9TBkBWI9pSuYiM5mYLm8QOn/BV50JNBgYEcKQGWLm1w1+iTyRt1iCOATRZ8KNiO46uXGjWbgOcBRPpBj+WrILr9CkgTWYHhZ2B14=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR10MB1572.namprd10.prod.outlook.com (2603:10b6:404:3d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 27 Apr
 2022 15:17:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 15:17:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [syzbot] KASAN: use-after-free Read in mas_next_nentry
Thread-Topic: [syzbot] KASAN: use-after-free Read in mas_next_nentry
Thread-Index: AQHYWkdH1s3mzBW1dEmclc5nTKEDh60D3zKA
Date:   Wed, 27 Apr 2022 15:17:24 +0000
Message-ID: <20220427151715.544aa2om5o7pp77n@revolver>
References: <0000000000009ecbf205dda227bd@google.com>
 <20220427125558.5cx4iv3mgjqi36ld@wittgenstein>
 <YmlaCVrwvZBlOWGO@casper.infradead.org>
In-Reply-To: <YmlaCVrwvZBlOWGO@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6635dd22-82ad-4e32-9630-08da2861086d
x-ms-traffictypediagnostic: BN6PR10MB1572:EE_
x-microsoft-antispam-prvs: <BN6PR10MB15727622A1DD6447A8FAF4B5FDFA9@BN6PR10MB1572.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4lIEHMU7GLvVaO0bzTGv9efOsZUKjakL5+d9uNlYpiAjSH4hEHiIcJT+bNM9xlkTED5niWDmw6YhNhL7Kv+vK6mijgrkbkIyoyDj9BOIIjNhY3pVlnDE0iWCD+NTnJyTFIdeN9YBuIKey2BKKi4YzWpxB8a6EQW4iilkGS9iE4UvdEl0nkdceVADNp9llnhgALySYqV3V8JN43JLRmhyk0PiNhDms7toZEokt/RCD7SSBuISc7/YzCZaESBc1xDGhbBaNlZ7NQOjKDj7CtW93TwnuxEaStjY1DqltWn8RW2tlE901HXeVSr4+LBaWAJKwd0ICw7/Ht88dhb0Obl087ffuHCiGDMcG1LsU+j7oyRpEaz3AIvvrnyCTTUfDv5uiA/xH7nCYw0f6ZaDYN/h7CS7bT2rTfmO3y9t8tdrGQm5tz1cZ9NAMpOaxtSZoa7b6kMje4pV08wqq5Bsn9iDtybjwFyMoCYjogcDQw4VBIoexdDnMDVPGs8FqHVZ7/r4e66xQgsjf456Lqk0EkDFmcOBvFLhoFn3qAhitiaGhjbBlfqB3y4ssNwG/+sopydtmwnlIAzW7FiYetjY5BbpKM2AOBQ+z4uXhX7iK9tLUsYScJRK5jYxibYQHwK/k9oyDX9IH+SRZn13mh9t21AytxHQCEuRqY5MKLRsBwgCmWSFnAuqrYiVoj2bvxmwYYOB6cHCGiP5wtiTCPxXsX6IZfzH1uxaanyJCwATrHgY5Gm1TjP4Ij61vfFKLfmfhorBj6HTfYmE/2WBjyGerUkeeXyR2Hf7GXxtbj2CDdCsmVw4QRARBm2nI68WAm6nxHlzwBT+8fRbi/dyVn72KHes23IDP2snlZLw6AdefJJjnGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(83380400001)(38100700002)(38070700005)(186003)(1076003)(99936003)(122000001)(508600001)(86362001)(91956017)(5660300002)(8936002)(30864003)(33716001)(2906002)(44832011)(6506007)(26005)(66446008)(66476007)(4326008)(54906003)(64756008)(6916009)(9686003)(76116006)(8676002)(6512007)(66946007)(66556008)(316002)(966005)(6486002)(71200400001)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WrM0JY7ll1inweLCsF/Q63UvqBbsOsNazuE6APcMlN5sDCBFdmeTVNyM0e0H?=
 =?us-ascii?Q?MihPwywALk4/T0r9vMrYCi3Mp5vQ8Z69wnefFbJV8ODipjQzazl4C4euHtSw?=
 =?us-ascii?Q?sGitbUg0wJsBTtl3ukFbwulBaWIKUKi+6mlyP/uR8ZJt1sNXGA4JmWSQNx/0?=
 =?us-ascii?Q?Hcr3MOvDbBKJbJnQUoRo/RiSjPWTluRFoEf/7tfT3J/iosvDg9VgDhx74RTe?=
 =?us-ascii?Q?qFRGxDz6RuXUDdY9cLYrFztz5F8MIaxhRKsot70T17Dm56FoHOrNozdCEkB9?=
 =?us-ascii?Q?pNaGKUV7xmbU/JpcRYjriGWlVpeSvyywxvYMrLJ7Ue4Lt/I0lgeYBn3R5ABo?=
 =?us-ascii?Q?9tqwpXmF0SyR/7u7MMMkklncZMYTgJUNipAkmLxCyRoLXrTn2Kqdw5RHWUUa?=
 =?us-ascii?Q?roXzM2+K4tdbNBUra01+93SN7ct/JZeI3K/knXgK0M7kZ0Dga1ZZeaegajPY?=
 =?us-ascii?Q?GUf/LXrgr6fxr2SH5TLAzXaKTCNdihGiQVcYAAYsmes/aqGEJ3XM0kFGe7Ov?=
 =?us-ascii?Q?2mpCVI4z5Yanun7ZlGCglg3sE2ioymsxKsnNgPluLr1SX5IZ5yEsyB82SDor?=
 =?us-ascii?Q?J8Loj78El1vNMBKr6D1qtO0zkwXN1lfiMTTb4mTCpu2u3kBOhQtOJcWfRhM4?=
 =?us-ascii?Q?4vKYJFae3B9M5cKmBMJO9HDmd/3PmNHeV3jnfNZo0rjoLnsCeLIfBB5cdL6F?=
 =?us-ascii?Q?9gW3TwrszX/dxamMTSLhYZat2Guy4ycZWbgSlxcj8rnOdYUasGPdxu3HSMYo?=
 =?us-ascii?Q?FpbAL9D4ZOnF95NhePR2Gj/UaCrvU6l670SkFyLv5qp4SX8MvEjN90yrNvF5?=
 =?us-ascii?Q?1JsbjcYWU1gtlsvTN5TpvysvLSYf31UUQoaX8kEGx2akqwXc2BIeLfOxCd88?=
 =?us-ascii?Q?jROKTpO7Wf0Mwv6KzKnumNb9Uyaaw/97XX0tR+aLLspls7oSHIkjQ7vGQA9v?=
 =?us-ascii?Q?l599e6BpUksu0FAwvVoSUG6Z890LUI+oWvJg7rgWm0pOY+rpOsa2WeO28Y1X?=
 =?us-ascii?Q?OySMPP4BWq0CMUfPCPP55v+WGBTmX29enHv8JfFmZctuTqx32Y2D1gWt5b57?=
 =?us-ascii?Q?Cooid+uMulrwBqOoPnJDnbchULdd0QktGcbk3cbOFJxreryODwgST6JWDZ4d?=
 =?us-ascii?Q?EC4xbbSvJxWfLkavl/m4wzRevXDKulspSrL2gkXBqqductkIGJAAU2VUe0Ru?=
 =?us-ascii?Q?TJibhoyqTwCqma6G8Hx1qhllhfblrdWsK5NIkIW2cuz6k+LN6vMOniunoC6W?=
 =?us-ascii?Q?tpKSWkaTC63EAqjjGp7130wfV/wjEXrR50F0H+dp9VGYtqaKQe72CcUSp+GZ?=
 =?us-ascii?Q?rbSRAERxkbNhfcS7dCUu/cYNxRvv+FwPUOih1ZfoTonKir9hQqLMkBnXDyk3?=
 =?us-ascii?Q?if4DuZVXoMQiIettV58Me9xXNeeODMKWe2ayg3yljHtmfXLrhOX1t4gUhZjz?=
 =?us-ascii?Q?Vq55RVsoyfn9AZGuxlURkGJ0EyEOPm6m4mgIHcpaDBuh5Ak40MflnKeBsmYa?=
 =?us-ascii?Q?o6M2/OlB0g7Fr7Dn/MCtqNoEKQMkE8rl3PfI/cYT+QlZO1jAULc7y9hE7xrc?=
 =?us-ascii?Q?mRdDV3exrVaYbA0HKm6ol1KU0vCxTLokVjr56W+VF611d7AvJv7gZhw3EDv2?=
 =?us-ascii?Q?AZptR9sijLo3d3xW38xLIMGzoSAWtSW7+upm5W5JwYn6o5Rpia9kabCLW6GH?=
 =?us-ascii?Q?Un04NOvYudbyeVs4ZAY18obqcNn62zMGscJhGkM9qYqbwqGi7o18eBnIBVXl?=
 =?us-ascii?Q?/C1GLU2oICHO8qKwlR7RqJz+5e6wEiY=3D?=
Content-Type: multipart/mixed;
        boundary="_002_20220427151715544aa2om5o7pp77nrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6635dd22-82ad-4e32-9630-08da2861086d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 15:17:24.4059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bOv7vzEg6r0KQ+lnZr+7r3/ZDUgBbzQn8tCcdKT9vYQrB2ndhm8vm2+8EbKBSI0J3eREDzYWMPcdMj/wdBPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1572
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204270097
X-Proofpoint-ORIG-GUID: m5GTWshcVnL1ASZdo8ioHXEuYQtpBAAq
X-Proofpoint-GUID: m5GTWshcVnL1ASZdo8ioHXEuYQtpBAAq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_20220427151715544aa2om5o7pp77nrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <666040EA0C2AC940AB2C335D2D505956@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

* Matthew Wilcox <willy@infradead.org> [220427 10:58]:
> On Wed, Apr 27, 2022 at 02:55:58PM +0200, Christian Brauner wrote:
> > [+Cc Willy]
>=20
> I read fsdevel.  Not sure Liam does though.

I do not.  Thank you for sending it along.

Here is a patch that should fix the issue.  I will ask AKPM to include
it for tomorrow.

>=20
> > On Wed, Apr 27, 2022 at 05:43:22AM -0700, syzbot wrote:
> > > Hello,
> > >=20
> > > syzbot found the following issue on:
> > >=20
> > > HEAD commit:    f02ac5c95dfd Add linux-next specific files for 202204=
27
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14bd8db2f=
00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De9256c70f=
586da8a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D7170d664931=
45b71afd4
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D113b425=
2f00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1174bcbaf=
00000
> > >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+7170d66493145b71afd4@syzkaller.appspotmail.com
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KASAN: use-after-free in mas_safe_min lib/maple_tree.c:715 [inli=
ne]
> > > BUG: KASAN: use-after-free in mas_next_nentry+0x997/0xaa0 lib/maple_t=
ree.c:4546
> > > Read of size 8 at addr ffff88807811e418 by task syz-executor361/3593
> > >=20
> > > CPU: 1 PID: 3593 Comm: syz-executor361 Not tainted 5.18.0-rc4-next-20=
220427-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/01/2011
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > >  print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/repor=
t.c:313
> > >  print_report mm/kasan/report.c:429 [inline]
> > >  kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
> > >  mas_safe_min lib/maple_tree.c:715 [inline]
> > >  mas_next_nentry+0x997/0xaa0 lib/maple_tree.c:4546
> > >  mas_next_entry lib/maple_tree.c:4636 [inline]
> > >  mas_next+0x1eb/0xc40 lib/maple_tree.c:5723
> > >  userfaultfd_register fs/userfaultfd.c:1468 [inline]
> > >  userfaultfd_ioctl+0x2527/0x40f0 fs/userfaultfd.c:1993
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > RIP: 0033:0x7f4e5785d939
> > > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f=
0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > > RSP: 002b:00007ffff7501a18 EFLAGS: 00000246 ORIG_RAX: 000000000000001=
0
> > > RAX: ffffffffffffffda RBX: 0000000000000031 RCX: 00007f4e5785d939
> > > RDX: 00000000200001c0 RSI: 00000000c020aa00 RDI: 0000000000000003
> > > RBP: 00007ffff7501b10 R08: 00007ffff7501a72 R09: 00007ffff7501a72
> > > R10: 00007ffff7501a72 R11: 0000000000000246 R12: 00007ffff7501ae0
> > > R13: 00007f4e578e14e0 R14: 0000000000000003 R15: 00007ffff7501a72
> > >  </TASK>
> > >=20
> > > Allocated by task 3592:
> > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > >  kasan_set_track mm/kasan/common.c:45 [inline]
> > >  set_alloc_info mm/kasan/common.c:436 [inline]
> > >  __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
> > >  kasan_slab_alloc include/linux/kasan.h:224 [inline]
> > >  slab_post_alloc_hook mm/slab.h:750 [inline]
> > >  kmem_cache_alloc_bulk+0x39f/0x720 mm/slub.c:3728
> > >  mt_alloc_bulk lib/maple_tree.c:151 [inline]
> > >  mas_alloc_nodes+0x1df/0x6b0 lib/maple_tree.c:1244
> > >  mas_node_count+0x101/0x130 lib/maple_tree.c:1303
> > >  mas_split lib/maple_tree.c:3406 [inline]
> > >  mas_commit_b_node lib/maple_tree.c:3508 [inline]
> > >  mas_wr_modify+0x2505/0x5ac0 lib/maple_tree.c:4251
> > >  mas_wr_store_entry.isra.0+0x66e/0x10f0 lib/maple_tree.c:4289
> > >  mas_store+0xac/0xf0 lib/maple_tree.c:5523
> > >  dup_mmap+0x845/0x1030 kernel/fork.c:687
> > >  dup_mm+0x91/0x370 kernel/fork.c:1516
> > >  copy_mm kernel/fork.c:1565 [inline]
> > >  copy_process+0x3b07/0x6fd0 kernel/fork.c:2226
> > >  kernel_clone+0xe7/0xab0 kernel/fork.c:2631
> > >  __do_sys_clone+0xc8/0x110 kernel/fork.c:2748
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >=20
> > > Freed by task 3593:
> > >  kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
> > >  kasan_set_track+0x21/0x30 mm/kasan/common.c:45
> > >  kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
> > >  ____kasan_slab_free mm/kasan/common.c:366 [inline]
> > >  ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
> > >  kasan_slab_free include/linux/kasan.h:200 [inline]
> > >  slab_free_hook mm/slub.c:1727 [inline]
> > >  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1753
> > >  slab_free mm/slub.c:3507 [inline]
> > >  kmem_cache_free_bulk mm/slub.c:3654 [inline]
> > >  kmem_cache_free_bulk+0x2c0/0xb60 mm/slub.c:3641
> > >  mt_free_bulk lib/maple_tree.c:157 [inline]
> > >  mas_destroy+0x394/0x5c0 lib/maple_tree.c:5685
> > >  mas_store_prealloc+0xec/0x150 lib/maple_tree.c:5567
> > >  vma_mas_store mm/internal.h:482 [inline]
> > >  __vma_adjust+0x6ba/0x18f0 mm/mmap.c:811
> > >  vma_adjust include/linux/mm.h:2654 [inline]
> > >  __split_vma+0x443/0x530 mm/mmap.c:2259
> > >  split_vma+0x9f/0xe0 mm/mmap.c:2292
> > >  userfaultfd_register fs/userfaultfd.c:1444 [inline]
> > >  userfaultfd_ioctl+0x39f4/0x40f0 fs/userfaultfd.c:1993
> > >  vfs_ioctl fs/ioctl.c:51 [inline]
> > >  __do_sys_ioctl fs/ioctl.c:870 [inline]
> > >  __se_sys_ioctl fs/ioctl.c:856 [inline]
> > >  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >=20
> > > The buggy address belongs to the object at ffff88807811e400
> > >  which belongs to the cache maple_node of size 256
> > > The buggy address is located 24 bytes inside of
> > >  256-byte region [ffff88807811e400, ffff88807811e500)
> > >=20
> > > The buggy address belongs to the physical page:
> > > page:ffffea0001e04780 refcount:1 mapcount:0 mapping:0000000000000000 =
index:0x0 pfn:0x7811e
> > > head:ffffea0001e04780 order:1 compound_mapcount:0 compound_pincount:0
> > > flags: 0xfff00000010200(slab|head|node=3D0|zone=3D1|lastcpupid=3D0x7f=
f)
> > > raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888010c4f=
dc0
> > > raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000=
000
> > > page dumped because: kasan: bad access detected
> > > page_owner tracks the page as allocated
> > > page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd2=
0c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLO=
C), pid 3286, tgid 3286 (dhcpcd-run-hook), ts 27966983290, free_ts 22717162=
691
> > >  prep_new_page mm/page_alloc.c:2431 [inline]
> > >  get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4172
> > >  __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5393
> > >  alloc_pages+0x1aa/0x310 mm/mempolicy.c:2281
> > >  alloc_slab_page mm/slub.c:1797 [inline]
> > >  allocate_slab+0x26c/0x3c0 mm/slub.c:1942
> > >  new_slab mm/slub.c:2002 [inline]
> > >  ___slab_alloc+0x985/0xd90 mm/slub.c:3002
> > >  kmem_cache_alloc_bulk+0x21c/0x720 mm/slub.c:3704
> > >  mt_alloc_bulk lib/maple_tree.c:151 [inline]
> > >  mas_alloc_nodes+0x2b0/0x6b0 lib/maple_tree.c:1244
> > >  mas_preallocate+0xfb/0x270 lib/maple_tree.c:5581
> > >  __vma_adjust+0x226/0x18f0 mm/mmap.c:742
> > >  vma_adjust include/linux/mm.h:2654 [inline]
> > >  __split_vma+0x443/0x530 mm/mmap.c:2259
> > >  do_mas_align_munmap+0x4f5/0xe80 mm/mmap.c:2375
> > >  do_mas_munmap+0x202/0x2c0 mm/mmap.c:2499
> > >  mmap_region+0x219/0x1c70 mm/mmap.c:2547
> > >  do_mmap+0x825/0xf60 mm/mmap.c:1471
> > >  vm_mmap_pgoff+0x1b7/0x290 mm/util.c:488
> > >  ksys_mmap_pgoff+0x40d/0x5a0 mm/mmap.c:1517
> > > page last free stack trace:
> > >  reset_page_owner include/linux/page_owner.h:24 [inline]
> > >  free_pages_prepare mm/page_alloc.c:1346 [inline]
> > >  free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1396
> > >  free_unref_page_prepare mm/page_alloc.c:3318 [inline]
> > >  free_unref_page+0x19/0x6a0 mm/page_alloc.c:3413
> > >  __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2521
> > >  qlink_free mm/kasan/quarantine.c:168 [inline]
> > >  qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
> > >  kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
> > >  __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:446
> > >  kasan_slab_alloc include/linux/kasan.h:224 [inline]
> > >  slab_post_alloc_hook mm/slab.h:750 [inline]
> > >  slab_alloc_node mm/slub.c:3214 [inline]
> > >  slab_alloc mm/slub.c:3222 [inline]
> > >  __kmalloc+0x200/0x350 mm/slub.c:4415
> > >  kmalloc include/linux/slab.h:593 [inline]
> > >  tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
> > >  tomoyo_realpath_nofollow+0xc8/0xe0 security/tomoyo/realpath.c:309
> > >  tomoyo_find_next_domain+0x280/0x1f80 security/tomoyo/domain.c:727
> > >  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
> > >  tomoyo_bprm_check_security+0x121/0x1a0 security/tomoyo/tomoyo.c:91
> > >  security_bprm_check+0x45/0xa0 security/security.c:865
> > >  search_binary_handler fs/exec.c:1718 [inline]
> > >  exec_binprm fs/exec.c:1771 [inline]
> > >  bprm_execve fs/exec.c:1840 [inline]
> > >  bprm_execve+0x732/0x1970 fs/exec.c:1802
> > >  do_execveat_common+0x727/0x890 fs/exec.c:1945
> > >  do_execve fs/exec.c:2015 [inline]
> > >  __do_sys_execve fs/exec.c:2091 [inline]
> > >  __se_sys_execve fs/exec.c:2086 [inline]
> > >  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2086
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > >=20
> > > Memory state around the buggy address:
> > >  ffff88807811e300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >  ffff88807811e380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > >ffff88807811e400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >                             ^
> > >  ffff88807811e480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > >  ffff88807811e500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > >=20
> > > ---
> > > This report is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >=20
> > > syzbot will keep track of this issue. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > syzbot can test patches for this issue, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches

--_002_20220427151715544aa2om5o7pp77nrevolver_
Content-Type: text/x-diff;
	name="0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch"
Content-Description: 
 0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch
Content-Disposition: attachment;
	filename="0001-fs-userfaultfd-Fix-maple-state-in-userfaultfd_regist.patch";
	size=1331; creation-date="Wed, 27 Apr 2022 15:17:24 GMT";
	modification-date="Wed, 27 Apr 2022 15:17:24 GMT"
Content-ID: <421CFDC7BC03684F8E5FD68DDD101A68@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSA5ZWQ4NThlNDdjMzkzOGZkZmY4YzIyZmIzODZiZGMzMzY2NzczMDkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBvcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCAyNyBBcHIgMjAyMiAxMToxMzowMyAtMDQwMA0KU3ViamVjdDog
W1BBVENIXSBmcy91c2VyZmF1bHRmZDogRml4IG1hcGxlIHN0YXRlIGluIHVzZXJmYXVsdGZkX3Jl
Z2lzdGVyKCkNCg0KV2hlbiBWTUFzIGFyZSBzcGxpdC9tZXJnZWQsIHRoZSBtYXBsZSB0cmVlIG5v
ZGUgbWF5IGJlIHJlcGxhY2VkLg0KUmUtd2FsayB0aGUgdHJlZSBpbiBzdWNoIGNhc2VzIGJ5IGNh
bGxpbmcgbWFzX3BhdXNlKCkuDQoNClNpZ25lZC1vZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlh
bS5Ib3dsZXR0QG9yYWNsZS5jb20+DQotLS0NCiBmcy91c2VyZmF1bHRmZC5jIHwgNiArKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy91c2Vy
ZmF1bHRmZC5jIGIvZnMvdXNlcmZhdWx0ZmQuYw0KaW5kZXggYmI3MzM4MzkxYjJjLi45NzRlMDRj
NTE5NTQgMTAwNjQ0DQotLS0gYS9mcy91c2VyZmF1bHRmZC5jDQorKysgYi9mcy91c2VyZmF1bHRm
ZC5jDQpAQCAtMTQzNyw2ICsxNDM3LDggQEAgc3RhdGljIGludCB1c2VyZmF1bHRmZF9yZWdpc3Rl
cihzdHJ1Y3QgdXNlcmZhdWx0ZmRfY3R4ICpjdHgsDQogCQkJCSAoKHN0cnVjdCB2bV91c2VyZmF1
bHRmZF9jdHgpeyBjdHggfSksDQogCQkJCSBhbm9uX3ZtYV9uYW1lKHZtYSkpOw0KIAkJaWYgKHBy
ZXYpIHsNCisJCQkvKiB2bWFfbWVyZ2UoKSBpbnZhbGlkYXRlZCB0aGUgbWFzICovDQorCQkJbWFz
X3BhdXNlKCZtYXMpOw0KIAkJCXZtYSA9IHByZXY7DQogCQkJZ290byBuZXh0Ow0KIAkJfQ0KQEAg
LTE0NDQsMTEgKzE0NDYsMTUgQEAgc3RhdGljIGludCB1c2VyZmF1bHRmZF9yZWdpc3RlcihzdHJ1
Y3QgdXNlcmZhdWx0ZmRfY3R4ICpjdHgsDQogCQkJcmV0ID0gc3BsaXRfdm1hKG1tLCB2bWEsIHN0
YXJ0LCAxKTsNCiAJCQlpZiAocmV0KQ0KIAkJCQlicmVhazsNCisJCQkvKiBzcGxpdF92bWEoKSBp
bnZhbGlkYXRlZCB0aGUgbWFzICovDQorCQkJbWFzX3BhdXNlKCZtYXMpOw0KIAkJfQ0KIAkJaWYg
KHZtYS0+dm1fZW5kID4gZW5kKSB7DQogCQkJcmV0ID0gc3BsaXRfdm1hKG1tLCB2bWEsIGVuZCwg
MCk7DQogCQkJaWYgKHJldCkNCiAJCQkJYnJlYWs7DQorCQkJLyogc3BsaXRfdm1hKCkgaW52YWxp
ZGF0ZWQgdGhlIG1hcyAqLw0KKwkJCW1hc19wYXVzZSgmbWFzKTsNCiAJCX0NCiAJbmV4dDoNCiAJ
CS8qDQotLSANCjIuMzUuMQ0KDQo=

--_002_20220427151715544aa2om5o7pp77nrevolver_--
