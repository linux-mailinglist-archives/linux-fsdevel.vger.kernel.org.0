Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FBF4B1376
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 17:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244821AbiBJQug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 11:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244375AbiBJQub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:50:31 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62722F9;
        Thu, 10 Feb 2022 08:50:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AGZcUD017435;
        Thu, 10 Feb 2022 16:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ps40MvnnJbgLjTeBchbkO99kQQcEPZQvlkiKbP5R/RE=;
 b=QFpRcGKDeP1mfyBYeaX4ryR/8p+LYWaz4r7dR297WalxN9XwgjkV9qfEp9gBDcZURx8Z
 Crk8rQUbGzBb9ndCakDTejzCTaKOJOo01I7ZbUrd1hV41vsfMR8CW1d+vOMSsrysmfcv
 I2yzYm/GgtZnDoyTcKRnfEAL67KosssHFZRHItqY3l6Ibsxney9zgevz0ld2vbbj0Unr
 ZonahP6WdFsZqgJ0QBHqg3gr367ocfiD1r2TF1QHZunm2LntQBbZBWhEs+gZsmf6OBNt
 NthdGavy+P+15twWPLYchtOhv+rwnvZlBU3czk2K4bZAU8JCZeI173dWUX0sPpcZdLbK tQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3h28rjc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:50:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AGgDd4069983;
        Thu, 10 Feb 2022 16:50:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by aserp3030.oracle.com with ESMTP id 3e51rtn09w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 16:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtMWpOovqFAM7rFCMc9aJQ9XahbXnBWgwxZp4Iq7qd7cA9J/tg5LpWhB1hBwtNnVWl+03EYq31rqzx3En2tOAQMS+JvyK5pWvSmjAJa04MkZ0Od+gr7VLiYCj7Gix5rICRxjhYkkIeJffwd507XVFAOltb34QIx5+jJoL+0VVrJ0VhJj5//6b6R76jslqqAhKaFIb8J4VwU+OuVPZ/hhhslc+F+558jUi8Zi81OHloGeS7kTz0z65+Vslx3KR1DQTJ/4JgaUw3dX67wPbVhYP441J7DwX60prdUzs+KF1+nxCx6zCruciQCFCoIU4GMzZniY8qjkzvwgh3/Yr+djpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps40MvnnJbgLjTeBchbkO99kQQcEPZQvlkiKbP5R/RE=;
 b=i6Mn4MR4mnRy227gz6WENwl7nhWa3RHqRIm+QFSKRBqxsfq0SJV9NVg8dfUSntAq+vuAd0tBjsws1znXJ0pJuXQKmCHDsyhVTgHD3JEXfAcB6dpUsv4HWuKeNv8XVV/QhWLNXwYay/+KMwKdboZiHxHzWQm1FimeAFeexkiLJARkpun4MwkByovDOYf+3kmnm6ZEc2w5FmMdbZbjGqg47ELoR1NxwYyPgpsyoZEOgFN8+rwNaXEk1KkaMdFg1XboLiJpiFhksSgtpg3zOn60hPce1hOtmtFewg98KA1VtNajjMqdQGOE+YEQPt+cc779OSY4ooDJMd9DRmiXN0UHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps40MvnnJbgLjTeBchbkO99kQQcEPZQvlkiKbP5R/RE=;
 b=0OOTt+D2LCkvLxm4+4t5RapLL/VCJG7yN5yvuBGt8jSnPzhAlEllQNWAd6A2go10xoMFHMvHVgwfWlcy3p7RF/gE7IRrvtQ9JIMqUp+SVTCSAQrmH1kaSCmcFnw65kSeZHPt/DHBu6iv5T2AHFsJkeSYUi10AmXoO3AiCC3JidY=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by BL0PR10MB2881.namprd10.prod.outlook.com (2603:10b6:208:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 16:50:26 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::c8a5:6173:74d9:314d%3]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 16:50:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>,
        Jeff Layton <jlayton@redhat.com>
CC:     Dai Ngo <dai.ngo@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Thread-Topic: [PATCH RFC v12 1/3] fs/lock: add new callback, lm_lock_conflict,
 to lock_manager_operations
Thread-Index: AQHYHjn6Ujwua4SbTkavmYzo8J2MF6yM2HoAgAAnq4A=
Date:   Thu, 10 Feb 2022 16:50:26 +0000
Message-ID: <2AEF8E7D-2F4E-4D88-8B71-48195C6E45ED@oracle.com>
References: <1644468729-30383-1-git-send-email-dai.ngo@oracle.com>
 <1644468729-30383-2-git-send-email-dai.ngo@oracle.com>
 <20220210142826.GD21434@fieldses.org>
In-Reply-To: <20220210142826.GD21434@fieldses.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 719c6268-201b-4925-9d9f-08d9ecb56fff
x-ms-traffictypediagnostic: BL0PR10MB2881:EE_
x-microsoft-antispam-prvs: <BL0PR10MB28816B29DCBE1234D4AB1946932F9@BL0PR10MB2881.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mr5hR3TgnjV7AaFNMcOFRy9Fg/8xlvqhls84GIZ/NnL9FMeDToTQwH3SllxckzMMowGPiew9movWIbtwiQbSIDnsrHbEAq1l60Zk765y3JNEo/iCq75cReseNCrOOEByWIt7Z9jbCmKcyqouhGwwgXYlf4vaPGyCI7y0piI/uiS0H0zjU2YOctk6ZPa4exLfuJkb4JqLZsf/0BjiEdnTiNpRzuT/H6HodbXzz0k94aEry+bBRgkgp8l03uJI7g4aBGsmYgXNZ3ajGGv1tjz7L3Leq6JJ49bG1FDGS4odn06076Ral2j4HTKZZn6ZwI/7Z3hBXcdrfhF96VCtZIUIrFao45tmlsLgrQ6geoXflcgDss4ZxnmDbEPXRcf+Oqfn+zrdIQV+bEX1FU+j18gdbaj7pYZzTfMQ1CbqCtDrNorJDQhJ6QDyzOy3iMzXC9DkW/yx6zzUjM8yRVbDdCWcKbkDYUYb3Z9kvZiEdZyBCYCae0HfWRoN2WLgG2gxyh2mQhtFAaICjCtXEtGeX7gfPVCU9AEZBo+U/YiIVNkx6gvpuIGyC3UkiNcZXhdbycZDo7sgzh7YyOJ4yD5W5boYuF/PnCRnW5rlAllfjaO8aDiJeEAT1Q9XNM3LuO8SoEKYbQ6bg8tqu7BksFljUmWN5tN3z7ByAWxD7Yfathli60Tl0Klc42ijoJCHkEJxDX8tIfIc/NYcqU3bFjvGDp4lzL4cBIQxiMbNTUW14/22ff/RVPQPe0Iew4OuJSAfX+23
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(36756003)(83380400001)(71200400001)(6512007)(316002)(2906002)(6506007)(5660300002)(38070700005)(53546011)(66556008)(66476007)(64756008)(508600001)(54906003)(122000001)(186003)(8676002)(110136005)(26005)(86362001)(66946007)(4326008)(33656002)(6486002)(2616005)(76116006)(66446008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TboHXGxwPHebir3Z8oL2KbOnklQJjSOfSZWrCDSMz/cJGfUqDkl949qjIT9Q?=
 =?us-ascii?Q?nZWtjEAwV2g7hXDPbSgQiLl+l5lprgJGVJKCLVoI7+HPbhMjrvNW+p73FFoV?=
 =?us-ascii?Q?o9o/TQ3DdbLvfMRSq2qCqstQUzu8Atj1Rkfsit7dKFLWRjlinbk9WyVZj9oL?=
 =?us-ascii?Q?r3zf96TcPSslvUkiMGgc2GA2y2MGwH2yy+0zaOVKDHHiFyovpvGx4+rGSk2Z?=
 =?us-ascii?Q?UCImumHLtRkDfZV4ybmf+MS1C562F8ZzM2ltXjJNJ6ljQ7mdr3xSc/GIwxAh?=
 =?us-ascii?Q?f7YjAxun3tTF1mjWKu10d3RFNacKBwHhogb801KiPBK5En6pCOWoBNMY0CP4?=
 =?us-ascii?Q?xzZ3lD/byJjEg+r/sFiWiszCpoDbgnu4liIsp0Nmhek7tIc4eWv5e3+Nv0Qt?=
 =?us-ascii?Q?NKwOesXov1NBpRt5Ctu0NtmPwoJKmZ0Pg3Wf1pD8CxxRZdIg2jx/j2lWS29P?=
 =?us-ascii?Q?uqe+It2iEkLNoc+8sApENJZY6vU3XyDbQzgOJzp4gwO4dRyoSacmnPJ01ENH?=
 =?us-ascii?Q?0U8RbJWlSFJNIkzT+fIA/RQxXSouXPciN30mQf+fm4NsPcKoPmxGNA+HKsKq?=
 =?us-ascii?Q?1TbCbo6ARr+818y8saTK4hhixYbcB+smi8D++Zb0hgYy94zfwybIe3DQlcsU?=
 =?us-ascii?Q?uOmdewwNDF1szZI1NGs+sPg+7pKKexIl5GECr/aHoxvQxj2rJVuza3M0uctv?=
 =?us-ascii?Q?V+cYJVC/YOPHGN1fgcw76p9xDu2h3EVtXYf/frQAzlXrMLWCUXOPI5XswHXg?=
 =?us-ascii?Q?bGRqnMK0TIfu3mgaHT1rUdeiDW4XyUwMk091yoCpe7jEdrDf+cLY9JqdrEQI?=
 =?us-ascii?Q?epjfl5l1dYJ95McOyASjBETAT9wvSltic0z8/wqTkLRyfIBsZBuID4PuahC5?=
 =?us-ascii?Q?yAafi+wWGZPUQFseuzWe6prmLTscsLSA+Dxz9vZ9hbF24w1ksyXd5I+f5Wnr?=
 =?us-ascii?Q?y8m6X/5/zBIRJAJZNN3j65DHuheoMi8vkcMK/3pUL1fy6FkRVuIU2yv/adE+?=
 =?us-ascii?Q?kEFZ7T3pyNbH2GOaFiQfSC3vHsYU7sxyXOioaWQL9F138UESfybSohJpOja+?=
 =?us-ascii?Q?Yo+PYCGipWGR99RXJnRs2uTRCQEHIiUdJK0z36DwQ3KCdxttV18E++Szvpb8?=
 =?us-ascii?Q?zrFeki/XH90FKyfdNISSSwamzGM1rLc+dFJC3+R67mOmDC8xXzwjHdwAiVju?=
 =?us-ascii?Q?dkFH5OmJRLZs/Az0eNzie9/b79d+bPOa8LHupP7KvfjgFG8TkajSkq4QhWfj?=
 =?us-ascii?Q?HxyH/1dmPF/XuDlLZCKJSCq5X0l8gxedFGgRVonD54eF4NA61hTf/DK0zmJn?=
 =?us-ascii?Q?XDqz8oPV8j802QWf9R5SBRz+JQbhP/pgKe9NoAg510skWw096ZK+oJDwFmOq?=
 =?us-ascii?Q?l5E1FqMwt7osT6OM1I2QRPH3TYVG/H2vbTs95GS6LU/7iqMT8o5HNjYG0veJ?=
 =?us-ascii?Q?ivUGCUj6QKCPC3+BSUm9e1BpdJFfq1xra/1pAWPbhYgLbv1q3WdC+VkkL6BN?=
 =?us-ascii?Q?08TBPCkeiTaMl20lKbSGnrwaihJPPJ76Fi+xY5KvMuuDZqzIFi6T53RuFWDm?=
 =?us-ascii?Q?sHUU0y+2KU+lsWeIL9RPVj1aM06Yam6vHafhSg4tFgxXYQw6eGkBFO4WSFbr?=
 =?us-ascii?Q?AAlrrVPaeweAJNxEU9SCU8c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50EF3D782FB5DA46869E8E7FF9E71C5D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719c6268-201b-4925-9d9f-08d9ecb56fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 16:50:26.1269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akbjlQR80pP3KM6tGJjD+zjXTdUApzCVf4IuTJvSP25ealqletBFDkY26Rt3GM1GdygXBBmPpSOPU6w/QxJ7FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2881
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100088
X-Proofpoint-ORIG-GUID: TOhD_jA7PH9TcgulIkB38_VlfFWSJenU
X-Proofpoint-GUID: TOhD_jA7PH9TcgulIkB38_VlfFWSJenU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 10, 2022, at 9:28 AM, J. Bruce Fields <bfields@fieldses.org> wrote=
:
>=20
> On Wed, Feb 09, 2022 at 08:52:07PM -0800, Dai Ngo wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index bbf812ce89a8..726d0005e32f 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1068,6 +1068,14 @@ struct lock_manager_operations {
>> 	int (*lm_change)(struct file_lock *, int, struct list_head *);
>> 	void (*lm_setup)(struct file_lock *, void **);
>> 	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	/*
>> +	 * This callback function is called after a lock conflict is
>> +	 * detected. This allows the lock manager of the lock that
>> +	 * causes the conflict to see if the conflict can be resolved
>> +	 * somehow. If it can then this callback returns false; the
>> +	 * conflict was resolved, else returns true.
>> +	 */
>> +	bool (*lm_lock_conflict)(struct file_lock *cfl);
>> };
>=20
> I don't love that name.  The function isn't checking for a lock
> conflict--it'd have to know *what* the lock is conflicting with.  It's
> being told whether the lock is still valid.
>=20
> I'd prefer lm_lock_expired(), with the opposite return values.

Or even lm_lock_is_expired(). I agree that the sense of the
return values should be reversed.


The block comment does not belong in struct lock_manager_operations,
IMO.

Jeff's previous review comment was:

>> @@ -1059,6 +1062,9 @@ static int posix_lock_inode(struct inode *inode, s=
truct file_lock *request,
>> 		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> 			if (!posix_locks_conflict(request, fl))
>> 				continue;
>> +			if (fl->fl_lmops && fl->fl_lmops->lm_lock_conflict &&
>> +				!fl->fl_lmops->lm_lock_conflict(fl))
>> +				continue;
>=20
> The naming of this op is a little misleading. We already know that there
> is a lock confict in this case. The question is whether it's resolvable
> by expiring a tardy client. That said, I don't have a better name to
> suggest at the moment.
>=20
> A comment about what this function actually tells us would be nice here.


I agree that a comment that spells out the API contract would be
useful. But it doesn't belong in the middle of struct
lock_manager_operations, IMO.

I usually put such information in the block comment that precedes
the individual functions (nfsd4_fl_lock_conflict in this case).

Even so, the patch description has this information already.
Jeff, I think the patch description is adequate for this
purpose -- more information appears later in 3/3. What do you
think?


--
Chuck Lever



