Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627B5520176
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 17:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiEIPvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 11:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbiEIPvv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 11:51:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674A32D624E;
        Mon,  9 May 2022 08:47:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 249EUtig032663;
        Mon, 9 May 2022 15:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=R9nbo7FZuTlHGuIPYNAlHAUy0jXqJj0nWNcsL+09Ess=;
 b=pjGd3jOKs3LaIdi2dK0dxtmeeu4qlQDWPEdIt2QNvPO8gL90w8x8FvHSxwNaZ3R0vPJ9
 EX+OtGLAcRU+8gWustQiZ4YXXRafnd3QsvVq72Az+j034OARusSTV6oAPaVT1mi7729H
 76SNOg97omyZmqO5XfdGM/SWuSBKly8CC85jMVT8B/+F6ytYYCligkrhuN/pQzh7sSc3
 hWJLCxa7wREr6+qYUOL0boDN4fAIC2eZuJDMCGXM256kLDxUVIN8luzWtcPOowKht0/S
 TktK44FoaJ1SW2Nz0YQLhKCLorBXO6zTvv6DpsQWYXvsONgnhp8oqf+wXSWD+yoV+8aj 0w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwhatbyuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:47:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 249FaBev004739;
        Mon, 9 May 2022 15:47:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf71rh1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 May 2022 15:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGH2AeWLhJ//gUrlJ5/HqyplxPKRCs8SuK1l2ZovBqKWdeLYx7FFVuhJdySjdlcsBwbmQ+Ok06MiWqPsAUzgS5u/UsZdZvq2Fdh5ZRLkz0fifhMGGEYZb5tYru+lspXkxiPT2BJSpgpMl6M3Uyl28lxzVRotPnXLdbEjCQjH5RnaSZpR+JQuuo8pTJJkBtGNXqF4oI/VfHlEajdXrzmFMmD3rWdHa8aR2Mb3g73E2jeUr6wboMmEUz38F2PPBKKqwKEd6UqMxPl4cYn7gmqUxSD7R8vw+sAfdZ0OyGsr8cqveAL7AeNUYDYCrwpX0YJEdonhHtulpM2ha7GSXk9F0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9nbo7FZuTlHGuIPYNAlHAUy0jXqJj0nWNcsL+09Ess=;
 b=iPQ4mX5evy8qNyL1t9nFQTSoU0P5V3qDOoPVJgq/P8MYyqaGvw2pNJbzWlp4Fs+2LFIqFIwuAHyxqDImcD0LCSrdIVysJbF4DT3oFp01sf/aqIydH+W5RCe0Zh5Fk5vEw+qbsj4A+6m61mcJNxktZdONBTuMAWx/e92o1sTYgdeZQxSO1XPiQJ/ouwLlhmpfQmYseg/Z6f3jyeYrWxgTjquIVEcGAjYWFNPDQqLThbqy/t7hwecuGUlp09x36ItQVIyh1Xei5VW1/hMN47GhrYJck8Cq5YkPGqlEgdWj2KrgQWPJlx+tiJGz2PJyrp+W43ooq71B7cpz96NCfZo+nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9nbo7FZuTlHGuIPYNAlHAUy0jXqJj0nWNcsL+09Ess=;
 b=SOfIVk47NGUmUl+WQVVMNfBNs/B2ymhoJoxIiogCO3zoq+21b3b4UkiqkXG/isA1DMpMJGrNs2dtne3TbQNvx8kqsqZb/U/GeEzCxhMYOMhA/uSOkv2JI6EgjHYvDHjO/bTjQEkrWw+YKivhaFmKBtiSyOCUulDYoUlcf7Thqr4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3152.namprd10.prod.outlook.com (2603:10b6:208:124::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 15:47:50 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed81:8458:5414:f59f%8]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 15:47:50 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <smfrench@gmail.com>
CC:     lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] making O_TMPFILE more atomic
Thread-Topic: [LSF/MM/BPF TOPIC] making O_TMPFILE more atomic
Thread-Index: AQHYXx8AcME9bSUZ70Wny3lit7kdCq0WugaA
Date:   Mon, 9 May 2022 15:47:49 +0000
Message-ID: <DAE0F6CD-F232-4305-9CCF-3F601124BFBC@oracle.com>
References: <CAH2r5mv7Z7XmyWgp5K8ZshA1OiMBTNGU-v8FdmwwkZaNNe=4wA@mail.gmail.com>
 <CAJfpegskJzpXXhWCdw6K9r2hKORiBdXfSrgpUhKqn9VVyuVuqw@mail.gmail.com>
In-Reply-To: <CAJfpegskJzpXXhWCdw6K9r2hKORiBdXfSrgpUhKqn9VVyuVuqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1020b36c-8e96-4193-976f-08da31d34583
x-ms-traffictypediagnostic: MN2PR10MB3152:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3152A40031E069E7EFF1251E93C69@MN2PR10MB3152.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DyYsZjRJg5DpGiECD63ynhkcqxgPuKp64VMxy6k70cqzkQC+5h4sH0RSH9C0pmwoE73/M3CLuOTID4t20apRxlYTC73lLA5IYigq8lxmat03OVww3Aod0OCVmrxf6w+ujAjpG1yhQgJBjvTVAAWTzl2e6jfZ0NjZU4m8V7p4FTk73pvO6YRNqQAWnS6QVHwai8r5ZoNC+LLdYMi7Fk5jBrFt2r8A9xsGJ8VQ6LJH4nPesUeqch/YGunDuglE/j+hbGnIfnrIbQztvqy3DgFUJqCh3mrZCX+VPbiLSn/t45UKiQxr8Tt8PZ1eM86y7Id9eY6I2su3elLBEVSMyTHiHRfbKtR3EnPzwtxXM3glLKSvrPbYvWRtxNmdCzBzOcwaB6mfSCXYeffJPzf8mGzG8TjZT3epjv1UpBZGCIlevy/YLkenQZ/E+8FwnLgW4I/Tsnw35bG3OMfbgVvpnWmIo8baW5fAU4/iiywRe2FYRqctkJRFzs+nDuYeP8Ntxj3S6RAxLMpGfwnpxzsejU5mDwZ4Q5zWOjUtb+CIgkUqr0ctFl4sVlXLjfK9KmNmvTHfteCpXvfwIOeUWnULL2FVWG1+2ou1ILeIZod+POwC/rJGWSdA+OD8hELsGvgbKtQWiGARdHrBLUOIxww7MCiw1RLZ4bDoFSnOJI8ziqE/2xgHhhorQb/jdaiq/QpXBiTyWX5hDnKt3BiKl5BO84XP28kCubTlm8IJWan+VS/trTpywE1WzNcJfIKdVuMrfUrc02H41fJEyU35y5Fhn6gQM1O4risozm3pIXmzhWJdMyDrhdi2RHIDfQaFV4gZGYRNBKW1WxVe6xGbO0+QMmAt75RUHPHQjCsVO/NpBfu+rgUJ7z7HEWeVIw7ItovrEZZB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(6486002)(122000001)(36756003)(110136005)(8936002)(33656002)(316002)(2616005)(4326008)(66476007)(66556008)(66446008)(8676002)(64756008)(76116006)(54906003)(66946007)(38070700005)(38100700002)(83380400001)(53546011)(966005)(26005)(6512007)(508600001)(71200400001)(2906002)(5660300002)(186003)(6506007)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xaDjnDQk2k0kXBG2oA2YlX2AHEHJ9GdUnkMHhHe0kwL+7dWdyTWV+TOayQvx?=
 =?us-ascii?Q?g5unqWRyij3PgkUWgjPXZ088LfaMNnIhuTRlS5pkrF4NSDadvUGDEHQSmpA3?=
 =?us-ascii?Q?hKQJB453Ss24IJn/jrErBJlw2ClGP8ATyBf17nqRnVpQrxO6+d05WB7VkhqP?=
 =?us-ascii?Q?pnlLHTVF4QznI3FdUaXN1RGOqeGCYn2BONPB8IfzT/LBlcJPxQ1FCTGvtqtE?=
 =?us-ascii?Q?4ajFHf+aGvQuKghBjhdKmS2WMrxklMnQx3OwL3RW7U/Xw7jabLPAFHXnscX9?=
 =?us-ascii?Q?TR8Fj/4EhwZnCzNHzRIYR1yyrr5wq1TIQaorNiNIczmHnAJ2HTG5LF6HfFlM?=
 =?us-ascii?Q?TRUMiem7WlR92ycbqztchKJYdEeXHMZoMi0Q9PxhrsTUEuKB1AT7bDqgDmfw?=
 =?us-ascii?Q?Vx0+9XCYsyrq8Tet31y8CNPdsg5SZWcHb/rXSL3xx/Wuws90jii/t1GK7eXg?=
 =?us-ascii?Q?VSYbL0QTHDqN3ey3d/zo2MJep45ggyivzkql4Ii3iD+salwixIQnpbobSh/Q?=
 =?us-ascii?Q?MozY5afQ0swvgFu3Y496HnI7OYwKZ9ifLHbAzn5/Jy5wg69Zp0LbpyQMX+ZO?=
 =?us-ascii?Q?Tex7abG8d4X0fKB20duYDkJd6GtCstMBW/d+iNWhmpUID9NO2BCtpEyVQiRC?=
 =?us-ascii?Q?FlAlvUMeyFaBQPLQKGIZD4nCr9kkKrnMN8kj/w7ALVc7a6jtpBmntX2SbFvY?=
 =?us-ascii?Q?BSWe3mCfyd+LwyU6hEmMK04vZNsrDP1J9p9XoJdDhI0aOFMR0D2IEDlkQUgK?=
 =?us-ascii?Q?DIg0lMCkJazyEnsYkDqmxUR0nysuTOlpe3TqEn4NYdAwRvZkaG9jj4HbSUQV?=
 =?us-ascii?Q?TQa7MXXuVwYPB7DutsuwmrQVXno3rFyQp23HQG4ODlUFbQb054w4keRF9XcY?=
 =?us-ascii?Q?HQ6G/GLoQR3dccSvGn+SzxqqggQQER0lZDTsRhrTh+CuDP98WBNDMUWnuaU9?=
 =?us-ascii?Q?IO5McSOEfr729ImQWGtq8HQBroXLk61++QRjepXoLxQqodC/KAENg3GZiDsB?=
 =?us-ascii?Q?mjCgVM4HIw+dm4OeFMziJDk6dI/LiUGQ3EWnhzv1xQljT6PT1aucu7y+V66B?=
 =?us-ascii?Q?FvQAbqc0Z7XwE2gGXu727RwH3S5MS6BvzeeoNsXll2CX8DWurGeGtH7QSE4v?=
 =?us-ascii?Q?7NrbQ9uNMFIc6E/JyToOEbydq3iTwhkgQagy001d+tmPXc6Acfzlm2AYGSmw?=
 =?us-ascii?Q?XbaAXSJtYM4y0DZxk4Bh40kome37pkXBsBpQuvSUDrGo+7UGln7gitE6gpC2?=
 =?us-ascii?Q?qdhl3Jqz4INFQy6nOBSw/Llh/TID77FBaLKERc/yVtwQ3QwoOMLsa6p4Ds8B?=
 =?us-ascii?Q?sRWqGQdsCiBPhsJhobz3wquaO32hdOMfP47kp15bfg8jVO7B/I18+r+7vaCi?=
 =?us-ascii?Q?fH7vWewR3pL/ph8HndWw7CrYBM4VChyRBUg5azv/t+eIX45AIuMAO5fx6JuB?=
 =?us-ascii?Q?hr556cfVUtcZCtc3mLxaXseLtnFSrkEzU6JQIbdt61UDO/w2x58BK5cNcQ7Y?=
 =?us-ascii?Q?Le7i2JdmU1alRVBvUZw8y70lBvdm21hW1hP5gq89ZAdg4snSHtpvPYkusHTH?=
 =?us-ascii?Q?m0xBmc9BwzqPAwykjeF5ekrHKKOJS8g2RUgvJ9Y7eJI/rHhY99NIzXH3fnD7?=
 =?us-ascii?Q?qIrVCuO9yty9NdgUK0Is3crE+dKWi1QZ/XuVCZh5mmNzjVMeDlGa1ljZg6ax?=
 =?us-ascii?Q?pz0tHcDInQkowOdPqU/A72JhHzVzvZedM87gruEpek6UkrXVNMe+hYF7z1et?=
 =?us-ascii?Q?eE4wz778fgSmDCvxuJv8Sgp71mK9jiE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BF4B23DC647E114F9A05E66935EB0F0E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1020b36c-8e96-4193-976f-08da31d34583
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 15:47:49.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvNoYd/xZoRoiNJDutp5kZccj/nfVqBYyLoTczrU+njHx5tDTpg+/d+BSr/uMntTu6/hfGhg+6Mjig5nrvjooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3152
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-09_04:2022-05-09,2022-05-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205090088
X-Proofpoint-GUID: jp6u6r6EGbNX24F3ti7PTgavFglIbJlh
X-Proofpoint-ORIG-GUID: jp6u6r6EGbNX24F3ti7PTgavFglIbJlh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On May 3, 2022, at 2:52 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
>=20
> On Thu, 24 Feb 2022 at 06:33, Steve French <smfrench@gmail.com> wrote:
>>=20
>> Currently creating tmpfiles on Linux can be problematic because the
>> tmpfile is not created and opened at the same time  (vfs_tmpfile calls
>> into the fs, then later vfs_open is called to open the tmpfile).   For
>> some filesystems it would be more natural to create and open the
>> tmpfile as one operation (because the action of creating the file on
>> some filesystems returns an open handle, so closing it then reopening
>> it would cause the tmpfile to be deleted).
>>=20
>> I would like to discuss whether the function do_tmpfile (which creates
>> and then opens the tmpfile) could have an option for a filesystem to
>> do this as one operation which would allow it to be more atomic and
>> allow it to work on a wider variety of filesystems.
>=20
> A related thread:
>=20
> https://lore.kernel.org/all/20201109100343.3958378-3-chirantan@chromium.o=
rg/#r
>=20
> There was no conclusion in the end. Not sure how hacky it would be to
> store the open file in the inode...

I just proposed adding a VFS API to make open/create atomic.
See 8/8 in this thread:

https://lore.kernel.org/linux-nfs/20220420192418.GB27805@fieldses.org/T/#m5=
05a59ad4e4ed1413ffc055a088de3182fb50bb4

It adds a sibling API to dentry_open(). I didn't have
O_TMPFILE in mind when I created this API.


--
Chuck Lever



