Return-Path: <linux-fsdevel+bounces-59875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EE2B3E7CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703833AE926
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3542EDD76;
	Mon,  1 Sep 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mPLyoiNE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KqcOrRz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1701F2343C7
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738222; cv=fail; b=Z/UIdj8AGxnJPihUsuqMfFYumssTgHoKSYxHRMdeXUuHV5DE0GAvK2UjcZgSRd4YrzSsFRBDFgWu1TWnywFBIniXJdKGEwmzSpESZoD7noxiQDUrG47vA9ck4peRVVkqxhmgchLjecSxNUEL1sbZPrPR6mgEAOJ+c6ixYKXznBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738222; c=relaxed/simple;
	bh=EGvg01xR5oavExOw/3DP0BEk+6Bur+FLzvo5JOYPilM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t7TZ4GzhFf8wvPnUMHaasjIbMffKWVdMDj8aqIZauUGBGjdncdKlWJt0KU5hf6WBlFU+G114Nl5H5KGt1tnafP1nVOIy+dr6xLqxgHK1xtWRoeb1/pGkF/N6rH1q0cYySrMAyu/BJCf8/zAWJr3N0YDJmW2pumj2cx7SlCsgH9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mPLyoiNE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KqcOrRz+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815g0Oc004901;
	Mon, 1 Sep 2025 14:50:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ICIk9AkSyyUWpAXz3U
	lCiWySrYdWv4PKFbKNL/MJPvE=; b=mPLyoiNEyPWCe6x+Cm6rnT32/r2pDisA+Y
	rgRkyX84i5GiNWIhPBuC4sONwvlb1lOACLETUwoApVFy3zj5EyF1nf6Mnu3t+xQI
	8N2Q5JetWrj6pctthmjuWAeSBAWBSt2EywkCI/g2DIMuvCLONmudzn08gLf60CUM
	GJWcUwUMMNYyNCxHbL7TqrOEBU4+yLVjvvw8iwpqxt+2ZwywVEzU72+JXeUriwiD
	7+g8xZw9hqHa8E4JXWr6fdQfO1a85qmjEcrl4f/1eGKYnPdHrg3Q25HHBPQ58hOy
	RXwpkO3bxfSSUG3UuUJMwi8uJ+80Ggz/ryvsUX46T5AQQPdtJM7g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnak02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:50:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581CmjmN004165;
	Mon, 1 Sep 2025 14:50:17 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr86t3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:50:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XDE251A1TTBhDd5mftl6q1DCIyfziPajv/ML3iS+4sk934Cm0Cd032xKYUhdb8BEoGmxAGJ87SD4ROE643TDLJ3FVVqcNMXp4RwRpHYFH7IKwEXCHfJH5L3x1w8alIi68HaoVj0dyNxsaKD97InAu+iFCdiqHRW9ppDNKjUXMV77Qivljq8Q/Xb6b7mdySslt7MBYDIqXO5dthwsKtkrIFjdezZCVTkNB3XpbFL4HJ4m4MD8U2N3T3lpjATDwssyzfkGQBjTiZhdUJ1D/1iDWIwPKbdxtRs9KUK0PNLevt3PfrpBVEQlcYR9kxTQ+E+3HbnNgmbdYt3EIDX98EUR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICIk9AkSyyUWpAXz3UlCiWySrYdWv4PKFbKNL/MJPvE=;
 b=kJP3g1xrPqbP6oaYBp0nz3ApwJDPDjxM82C9nY+WCWYqt1tUe6CaqFeDyqpindCZkQ7kbkZSbeu0TcXAxIZ6GGiDqNdBD8sVRx03929BCzfZhcGJZvVJSJKiV0QuEaFI/n+FVreAXTTqPZTgAInHlcdk4eehr3kq0nalagBwPVQprtBzAJKbPRB8crQD6hExCUT1dJ8SurhvwI5hxTYW2R0726D6OeU0IQFWvdXc+0oJv2r8Gmm6N0JTTeN5QIPcLvM5fhwNMB/wf3vjdeI7LlJ7yMS8tadjmZuQzfIeivxBjatnmjqCSocixJ0VdbuapbYRLNYxZTPLFIJRceMEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICIk9AkSyyUWpAXz3UlCiWySrYdWv4PKFbKNL/MJPvE=;
 b=KqcOrRz+Z1TJTUmk2RA3tvY9fHre+wH/bHmerihB7jnT4AOACcEG8U+X+YSvL9v7oWuR35MqPRTJv0sVRU4hp28L+NgjACj4V4awnY96UJT+Xz4oU8tYfcOTLDQRAXsZb2JkY8K2l8PWkVuXECV6zgUZEIbWi+mTDrquQVN+s28=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8709.namprd10.prod.outlook.com (2603:10b6:208:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 14:50:14 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:50:14 +0000
Date: Mon, 1 Sep 2025 15:50:10 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 09/12] mm: constify ptdesc_pmd_pts_count() and
 folio_get_private()
Message-ID: <c8a76d62-6250-4294-b11f-661e1aba574c@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-10-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901123028.3383461-10-max.kellermann@ionos.com>
X-ClientProxiedBy: GVZP280CA0098.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: ce829ced-f22d-44d0-812f-08dde966dbbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lN4OwRZymjgtFu4Rz4YvuLOOtK2V1G/7SUHOYMNXFMHH1qAyazOqbPTks7ZI?=
 =?us-ascii?Q?l5pqpRVmnJaU3sX6uBRiyvaDyDaTWP0sKk0JukeHaK85ToH0ftm/szUGTQlK?=
 =?us-ascii?Q?Cc/GOhD6xZGeaZP+lQSjVglVieftsZMh+vRixLlRkBOgu7FCaof4Xvh4MWN6?=
 =?us-ascii?Q?612jagij6hXDWDs8wYjo1yhGMVcIvrQoUHMS2MftzTm13IYTTfbxpS14cwFp?=
 =?us-ascii?Q?oqMKHZjac5HR2ieD5zFTvNaSMyN76fIm0DGRI9cJl5NzrCboS4rYeYOCcDxa?=
 =?us-ascii?Q?1T5yRlfiwZfTGJJzMj7oRFQ0mEIac1SjA9FqkJXBxcxChxc9afAN6NoSzHof?=
 =?us-ascii?Q?iKwHTY6wwSQfoSA+Jdw+ScZ4ZhD+yVb1Z9hz4L1y009gqg6070R9M8jtodsv?=
 =?us-ascii?Q?81Heoo9shjcnisPMeNjtEu8Y/TsVlUZMKfFPbmUtC7XbDFfWfCfHqf/m2hPu?=
 =?us-ascii?Q?pnPZ0NH7WiUIF0IRuaIkihxSgENCqr7sq5oqNbr6QD7Zp1AHZdGaw5JGlrQE?=
 =?us-ascii?Q?cjvEzoROUJVIrzkLTjYrRcDJTkNXeTiOseYb9e58gmbJzO/gQG66Ya1QeU7O?=
 =?us-ascii?Q?G1PQ0HYkKwgxN2K6ZZHjOBLOJl3QJQa0Lmg9+rQYlgNmCzHEgbsE40XATFmN?=
 =?us-ascii?Q?mrqBaviEEtjMKziahcts4QgfwuPuAO2n5Txce0Rn48ArMpRluAG4vAorSGbC?=
 =?us-ascii?Q?H7+tgh0PMurtd/X8v6jFaqVp5ObIZGD1rXPrsRJ+gm7MPdD/ZAesur1jGPL5?=
 =?us-ascii?Q?Hea0DT3axfFIAUz8J35ggPrN9aReybookhE/111XE7FAwmsWiWNjll2uzSI1?=
 =?us-ascii?Q?aMcE5TGctqzlByFRCxOPQsq3iHS2RS7OhZ1E9HiN/UaQbFbhC/IeW2LPB5QI?=
 =?us-ascii?Q?93e6lnDTLhp5wEGQrBrxzOIKNfqfFAUS8j9iIrtsmUWU9ZbXuE7IKoIG6Blj?=
 =?us-ascii?Q?rgfZ1RPIzfkfoKmh+3v5pXZgVT/CAdWQ+0XEMh8px5GuZgGUtYUWVBJv0Gy1?=
 =?us-ascii?Q?oWJBA6VB30YY07otz58Ki4YK2Olevwd6py2mqW8lvCIowkCTWbxE0ITR+W+G?=
 =?us-ascii?Q?HJLH74ygSO9MG544+pDYERWw2Ye6TZG0QjhzDwHQknQhu1G7c0ulH2lBXFym?=
 =?us-ascii?Q?+ttzXl+klh9ChVGLH96+P0v40B+EfubJoMHKIZcFlNdwPyJK2B55clM/0VoI?=
 =?us-ascii?Q?LvQumVKMDFXDI5C5iccG2Zh9BEnrs/DDCa7neZkocE+S+F2Xa78r8IFpeLxU?=
 =?us-ascii?Q?HMN2Ls9EDqZnCthT3xm3gor9Gr7LLX/XzP8u0jDoO8grwlsBHWHYR/t74yp4?=
 =?us-ascii?Q?KodIzgpupCu3GUDGDbnAmrKJJKRSdj5n9NCrGpwpVvuoJLZ8wdJ8s2PpmQlx?=
 =?us-ascii?Q?g3CGEa4PWHtIyofN/2uEN+vGAZ4ICgjNR5L2ibgV3Q37EgQ6cA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aMMAQkXknVAcegPOxkjGqhEOWrCch9dBJrxHOKY55Yd/KJHqZv9+lDzrL2Ix?=
 =?us-ascii?Q?MtM/sYFdZ3996OHeDTWizrD5LwUtV/Ncsw4MqfhIsy2DBh3QW4ALaseD1rMS?=
 =?us-ascii?Q?0Sy51eotHWllSF3lGjflAHsQgqhGr+IO8UV/A5Q2XtET3Jg7zre32XtW+w1K?=
 =?us-ascii?Q?gwetDqi3/ejE8CtTRBi/kz3fNyECCxp3CYISep/j0btqZIjklAFTqncLOSoW?=
 =?us-ascii?Q?Gl0azcF5PicIhBRvd5Ot6z0+QHKM9yvD3GYZgzCJIafRYrhDB7hRljurfLMo?=
 =?us-ascii?Q?AjyIbo5O0X51ymSovA/69kwROPf9/WoPEqmgeypEzvbIezPxnQfrNlJbdXgs?=
 =?us-ascii?Q?lEPSOZDhxYPpEsHpUTL3nKOE/r5pu57irj+PgSUPTqY+zBcdMMYKEiEtrykz?=
 =?us-ascii?Q?AHx8oji2XK8OT3/l9mI/aejAMM2SMDtCgCDX4i7gg8hSIOOSfFh6PFkHvyel?=
 =?us-ascii?Q?7MZXAaW9jJrqYl1eWw53TOj+U2i5gQ7fMrdJpAZTCIetiGjZ0BrvxdnfyAer?=
 =?us-ascii?Q?+wSeeGhni4pKQawgmIqUX+QackQq0E43Pb6fN+hLkWuhK7uKWennwVknmwj1?=
 =?us-ascii?Q?XE/Dzkx75A2oM4oY8UVEdFZ+daa5XOxngbKZyoHKi9DLifN/PI26it5gFQCp?=
 =?us-ascii?Q?XTnkeuQDiQwKBz6xta+aJ/OO8L9XEFlERz2jPt0N3IJAGaSP99c4gK3gDF7b?=
 =?us-ascii?Q?0O/1okC5HQGVYBshoW8hwajJF0sY0zTmd+kSa2mDmkyJkjxzIKWRZ5BHpH5R?=
 =?us-ascii?Q?ca4lRFtBOE1ZigDNXnSueK/J9ZWbpbkaihwsJKxzIMI/XRwWOU0iClIBETPi?=
 =?us-ascii?Q?P28lGFTPeVCiUnT3kMWrofih2p3hSZShwN1aZnO64fAv62kq9owwGz48ZZFw?=
 =?us-ascii?Q?UB0cBIR/KrbO1yzOmSMdhDx+7dZjukdCXXGfQKKD7kNfGjJuQz8QOEBHO6UD?=
 =?us-ascii?Q?DVAJxaWLnrqRHj/QmeR50jLXVo4nps/F4m5BmXc2UUhPAJuwIIibwVAVNNJq?=
 =?us-ascii?Q?oDVvvoo7upYiV97xrrZNiUA4oAx0EvyN3mZ12mfbatilpD4rkYWY2cez8XAq?=
 =?us-ascii?Q?/JYwZC8WsRP0XnT+jC81czE+hppoLXYlV9BELpR0L8nZsxBvIywrtbyeBc65?=
 =?us-ascii?Q?4gypaoeryUcK/2BnMdrQBHF+DCLkTCQIYE6DRWB2eFO5J5EBCnFOopxBfnod?=
 =?us-ascii?Q?rx3E8xbrrM7WV6+t9FYww04u4tOAGhQBlJWvHJ59D1txXjYAl/yKvx+I9CWa?=
 =?us-ascii?Q?sBXqzJ9MPRM08/wsQ23tLKAYpI3HXeMEozr6E1VkqZoiO7Wo2TMZasOZgE/q?=
 =?us-ascii?Q?JgfNNJ6GMOu1cPj1aqGNtZrlozPhGsn7O328yuZj1gui7olvfAN2UheBymmY?=
 =?us-ascii?Q?pLXrY25Mv/asSMggPjSeNc3oK+FTdoQkQ+jqu3WKPM/l7WJBBjUb5OkvFZRU?=
 =?us-ascii?Q?PNiAuxXETQ1u0DzhZF3hM4jj08A0MwYQxLQwIF9N2HrDNODYCDF/6pOWN5Vx?=
 =?us-ascii?Q?nA5itad2fmOsOURtWLYPuQkFcZFPJwY+O8ZNwHUWFRptjLvGjmXQDcqncUDf?=
 =?us-ascii?Q?RgVdagxDv8qaQxu3pIazt5xckfE5J4gHfhUK1D9wu1J+jL3RVmIKKUxNv2UE?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	x2PdXUzEcUMgpczE8Fc9ECEJi2LhMvlsAmP/r9JA6fdEI7hGXwxpvFayKkzTUEE9EW0T/Inpi77VpQlGNgj450yjnkpjhB3s/+6VB5xovMwaXM9OghNTnddIbtRoF2dDzxIfcfhMrP3xMKts6JVrALTg2CwZqio2gq3UN+ZTtNrKln2bn5qk3YCQz36abf1pchMDVJ+XNaYBPa1HL10qtqZ+PeazVHWBxEHj32rRtxbajLd88SkAC9l02KmUVMK2FqnppTEX+/k3PouTsZijm2DzdE1SQ8K8ytKTPxJtzrKHrnOAgz1sc0ArSYaMf8FjqO3FIsv/UbsbBS34+BmqNpf6EQV/6vNZ98DAThPWYTdJ6u2v+bkf3EYfeSUKh7triLIbJXl8svST8UzWX27v5gKhZThqnOcm3KMPhhijdlr0R0wP9cxEt9COlwPyfH2CBHx5hq2e/P2QTL6Ex8MYwyb9XrrZ7C1/bfzxDxJ4AT0LFnxbH0A37AUR5EXxLX7/KD6jtvoUA2qkA2OaRNnMz4CN9kuSPXzdTKfN5KjrGWGbWYJS9ypgeb6bwhI6HhmQBDZDbgTKde9W4seNrQt2PGZhnek8W4Z8z5Wad8aJKxQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce829ced-f22d-44d0-812f-08dde966dbbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:50:14.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVD/jv0n4rBkECNeL1B4qrHMUSys0+XqNVcwjYZrBadelvYr4flgOTS/W/ZEHyYpHQXWoGVjwGk0WnqLiADSD6Vc4lgtJJroRd8Cu16p/fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010157
X-Authority-Analysis: v=2.4 cv=D8xHKuRj c=1 sm=1 tr=0 ts=68b5b2aa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=nN78jIPOpIwGFdwYtvQA:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: CvEtvc790aFSftMfnwwUiKLW-qwlsXaV
X-Proofpoint-ORIG-GUID: CvEtvc790aFSftMfnwwUiKLW-qwlsXaV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX4sYcEXjqZz1O
 GpyKzYxKlK18/ININjkcFP7INf5q3nbKmIIOF128R8DSq4Xw0oJNhdpPA4p5YYNJScStqcn1o9q
 GtuMmi2HKeEsHv/Qo/4fgw2Lut+VPbpYDYllsQSoP20YbM7Fow0TooqMYeRvF1lZ7MrIF/eo9fR
 SUtA8rsqXYOWIWknnqLsd94mQHaRvTfa+Iesexh0M1wPF2JNcVqu/MPQXuc4y4Kr6M0JN3zvK/1
 r6KsoU0QNLQ2tkBJ8Dm/oI44pjcobAqvpQlgXGlY+PVeu0hO+1toXe0VKN0jzYDLaBduDiIlYlC
 cnAEcJQkbTyLPTaUPJeuQcxI0ybGbzLp6g692L+9YzmmHbUOYe7l/qiZ3af16XvLtlMcAFn/WbP
 u3pcgxlk

On Mon, Sep 01, 2025 at 02:30:25PM +0200, Max Kellermann wrote:
> These functions from mm_types.h are trivial getters that should never
> write to the given pointers.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

(Again, on basis of us figuring out whether we want the double-const)

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index d934a3a5b443..46e27ee14bcf 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
>  	atomic_dec(&ptdesc->pt_share_count);
>  }
>
> -static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
> +static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
>  {
>  	return atomic_read(&ptdesc->pt_share_count);
>  }
> @@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
>  	page->private = private;
>  }
>
> -static inline void *folio_get_private(struct folio *folio)
> +static inline void *folio_get_private(const struct folio *const folio)
>  {
>  	return folio->private;
>  }
> --
> 2.47.2
>

