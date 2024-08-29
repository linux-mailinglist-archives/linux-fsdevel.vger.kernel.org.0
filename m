Return-Path: <linux-fsdevel+bounces-27875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC9B9649D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33446283725
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E21B252C;
	Thu, 29 Aug 2024 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ta8CPafC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JbogWHwQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0903F1B14FA;
	Thu, 29 Aug 2024 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944765; cv=fail; b=TZAH6YER/ip8vtcfBaZcODlz0xCPrEhGqEOSDisqq50BL2D4NLMlHTF36VnjeJz0YODGbXZtQylbKGc7xtlgr2STYvagsN26SVMhGy85d4uaf9T/iA+OzgqVQR4rlZWf4zkCjc33LOOd4TNdR6NXcfE3X2ODqqnx5dGv7+Nxcno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944765; c=relaxed/simple;
	bh=muwvNfZvS/hs7jTLO1ZGXJlGIJF8mKYAPKeVeiZnc5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qsubLMvgZHSB++TpNntE8ggz5B672dRvd9GVdkklFuyZZyz3il0PxheGr6SfTAQUKZbaozL3uRJD6vHfE8dgBCmgXpvZIn0/PG8iVeDoG0OSkIA2VBrhYbRryi0YoEjw8eNVT0WlQ//sgei2SnJqbRCkrCDTbvBaN6NxiLECjZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ta8CPafC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JbogWHwQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFHUxQ001094;
	Thu, 29 Aug 2024 15:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=c8K7T5ISXcNZGjQ
	mK6oXYlq1BI08KCCJRGafjoY2Wg0=; b=Ta8CPafCghhHQ4ycfr82hARuphlRfWy
	qBqyO3fBoF6sAgYSHAeZl1VY8Kcxl0pfMTK9sfHNkKv6nukCwmnVLCNeRocJaGgc
	qT+EOmzUcRNjKr95btZI110NrJbh+cd8oPbzg5ru+6hegoijiyf0xJWDkxLcLt4p
	yyrn3NR7GMIJHqOKVMLtsvn10AQnQcCD83C4I94B84tWgJ+0271fnd5XIuNsqVte
	tU6g+g4Gtve7BTdsDer/6dpZTM0qUOOn1ylWul7/39q8KoBoVoouultbrgmpji0v
	BgFQ5dsIDZYF3uNw67xQVfTn2ptnHvt272EvTVDJNLbJNzARB5AwjnA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pus4evj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:19:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFJ0SU020291;
	Thu, 29 Aug 2024 15:19:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8qktxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:19:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dzr5GL/N6pjVZurUv5tENCVZrx+Ri8Dl5VWAB2DtWqc6Jz+3kMFz812DTPb+yLBrgvVDFSRzaxJtjA5EeSwGGrQBA5n2Sggg1snUIC9Qh2JbRkuzyhwX+T5HmNDcsc4NgAdbCwXoe/nQzNDk5UPiRAF4bINOSMo57O8SgMkXsOnv98bXVKbZAOBYYIoUKJI1aTF/YHvwMJWmDVy4XWuNCncvWD5tVx9ZgFMh2lRBcJEonVN6CQdWiZIGfk7sfvRUNY30qsoFK2VwsoaEEQ2KGNHuJBPzNLS39I0tm0bKEWh1fL94k+p1IQRGod9x66jKJoZ+JL7+vuyb1o7Kd/5U7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8K7T5ISXcNZGjQmK6oXYlq1BI08KCCJRGafjoY2Wg0=;
 b=ErPXhqBJDsrwKq8zQH0SU+oE4QWLvLrGKqbnDerIe/TdUvkny16uNE2UJVtfqwDTMthEQZg1RoLV8HMdzISWKmiOCzg5nyZkspSwEEibZgCFu3X65aGAIOotF5yMGSx/FCNe2MMyjcNWhtjOaKGwcmutiAMoVALEto3yxk8KUyBFNlJSmuXg7+CcUjGoQ3uTJIxcH47pP1XhKnn6I/FUgXiedwjQqIy+XIZmk82wQ+Xol7c3WK8Qzjgluliu71ct+38dTLbM2DQs4QHg65lqIa1wWp+ZB1s8vc5EIBbdSq2M6GeRcL2JK2YY+d12xb/cdw06gh51m/+ruLXX1CbwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8K7T5ISXcNZGjQmK6oXYlq1BI08KCCJRGafjoY2Wg0=;
 b=JbogWHwQ5pxEHcvUWXm8p8cK1fNKgbh2ngCT2NvRDPRbQWKOXrzvbHnrsuM2JDE/KWhhbTq+OOdgs4IqFGvnX/eSZbM+HUHt1ClATiW+tw1IEkXAaOkmgfm+fCzmaLfP4LrdZ0t5iedk39xs93wr0+kZ8bH1I3CeOuWiMJ9EFc4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB7849.namprd10.prod.outlook.com (2603:10b6:510:308::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.18; Thu, 29 Aug
 2024 15:19:05 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:19:05 +0000
Date: Thu, 29 Aug 2024 11:19:01 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia <okorniev@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 06/13] nfsd: add pragma public to delegated timestamp
 types
Message-ID: <ZtCRZegWZ/j4j2Gn@tissot.1015granger.net>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-6-271c60806c5d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829-delstid-v3-6-271c60806c5d@kernel.org>
X-ClientProxiedBy: CH0P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 13560fd6-84f6-4da2-5cb1-08dcc83deb87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8mbm9q/ytmoVDSAGlCd13SYFJOSdMBXpYLzCqv5FV0iBWoA6oUyMFRtdjla7?=
 =?us-ascii?Q?H/FEHyj0rMY53XDRlXJokTZk8oatWriqHZJGSGMYUUiTzuhfQqvaW1dIjz5f?=
 =?us-ascii?Q?pTtkqXstdKzCMLmrBJqASIUhQ/o1VKOhTyD+3u7NJRbNhECB1MB+vDIbGBXf?=
 =?us-ascii?Q?aRyVA58smvja8iBLEMBJuIu7H/QZlSW7cXAkoTX3wSXdQgI4lg/gxINvAKXg?=
 =?us-ascii?Q?Vo+TMUG0alWK1jyB2jEBnXQVI6G38GrttVYaVkgPKl9z0rbLUxYDGZhCp3BX?=
 =?us-ascii?Q?r+JJghE8+iz/pCorJTN1IK4SUJW//AwhRQ/huCXXM18HJniyQgnJ7NwLjp5g?=
 =?us-ascii?Q?oom+PRmqFN2bk2KBR4oCnVDwHdAdTarI3MKuqY0EfQ9gv9qTFe31pjHQbKWS?=
 =?us-ascii?Q?KQQHINKGm4Ux9mKjueFtOClqQKUf2jwVDYTsOZtNg7pxMQ5N82sYiht6OglV?=
 =?us-ascii?Q?xh98i0wnsmoZyi7o3jWvXzu+wtoqFL2xOVuS8lM81/qo9ZGlSn26mRdk8Q2y?=
 =?us-ascii?Q?mExVP/92OsrZn+BdR7PjTBGRN23DM/+Qn1w8XOppOmn6IZHMyL4dwS33A2yW?=
 =?us-ascii?Q?V/JrucukoBtYqb0AETboyjJ6sMik8moxLbsW5lvkDscnlo6msrC2ZQT2tWfA?=
 =?us-ascii?Q?Yx5UBAthBEE9cpKiAhLHK7KO0g+PqU/Rw0ENnBB2BAAYBcZoFXD+hQ1ty+yH?=
 =?us-ascii?Q?+ttsSn5SjGKoHT2+ubXBNy1MFdU6pd2B4p+MWTJazufX/4fGwSbTEtDvZgaq?=
 =?us-ascii?Q?9igw6JkOootQJH0B3iBpC2XjGrWRtOTyHcbVjNvcsA120SB9CW1jgWAx9CY0?=
 =?us-ascii?Q?AsGG1ItyJeHz4nNMDREWeo1/xMu1pgjOUqSoQ1ZxnmoR6FsDzVKe1RSZo4dQ?=
 =?us-ascii?Q?HiInmtz+npMJmScNpVxDx532HwKA38so+EJ1j35KA4SEhp4BmlwDlnthWIpj?=
 =?us-ascii?Q?4TuV/8snl4tZLf9WR70weYHJULeqR7jZDQagpMxzXe7TiBRTQ5MQJvkdfPqT?=
 =?us-ascii?Q?4i3I1aZrn3JdNQBKO6ZzICE1bI3sXFw9j1c4VR3m7XKcQ8XYidPfA28u/dec?=
 =?us-ascii?Q?KETgc9NH3u+IPoqHo5AOLeg84HfD6kUpidi7uCpkoJaGuZihtWC0jeP5wex9?=
 =?us-ascii?Q?9l466v3PYkTUA68opzybdY1OzP7VXOvjuVbgXbSR6pVMWy1z6iajD6XJVW9U?=
 =?us-ascii?Q?0T+55h23kfxbXUg9uCnHn6A1az4VUAbTGgoHrY3ObyJ04n1VmVbO5HQrHIGJ?=
 =?us-ascii?Q?Hh73AbqGsyXM8PARbw/Uuk4wycfAo8GRNBK8tJiUg6NYTUd+p9VGuImzBHtW?=
 =?us-ascii?Q?t+qVOeoBBXo5skOhihKxD9IoP2pEXF/4t8hArkJ/5O4AuA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YeABUK/b6te270HpOd6Eb95XlqeDxfB4eERmpsOUYbZSa+ZH3ma+Z2UwPTyG?=
 =?us-ascii?Q?OIiswjw1BbEoJFsg0E9zTdzzJnrVuY3i//X6XGkbfFEBl0rrc1uONvJLkTin?=
 =?us-ascii?Q?FAh3igwoNHBZsS0tNrrPp9RzUE2RxOvLyRButooYJzHh1f3nXwAv+wQcYJ9e?=
 =?us-ascii?Q?BJkEWu+Tx0sCbMrVqgkGyaON2y9Fh82IW7tbpeGB40uy00kVsp5KYWl34Ven?=
 =?us-ascii?Q?zRwd7aA4Fyrh90Gqzv/DU+QF359Ld57a2ni1CI1laab4dfqxlTwyYfmKMOXg?=
 =?us-ascii?Q?xwXEVoY1doh964DyHLWlKtRNUdqxm2lj7R+X8dyJ+vw/RK0+7goe+foyBp1u?=
 =?us-ascii?Q?rA/ogXh+oGSFlIJkIZeDdpGzflgFofEiyLAuPeAEXAUmwAMG4zzIxNCBmaXI?=
 =?us-ascii?Q?KK5azaG/qD5/fcmkFUwQQYtFOCXRLQTdDIMIeE85UPXdEk88bK4BsPNyGz1j?=
 =?us-ascii?Q?YpWIbzJHd0xfxRzXg2rZ6u8ozJd1IEh5N4kzGF87tTvb+CBUKggpdAroGlgw?=
 =?us-ascii?Q?72FmwqaoITwToGIzzZsz83BATEp56h4ZGT+xTyPaptFQ5Cfyi26u/60BJ3wE?=
 =?us-ascii?Q?MAYPCfeTUd7xpD49vqi0nFWi0oqy3Ll5qvgu4oK2D1ixFsFoG3E4f21QM+B+?=
 =?us-ascii?Q?PUmr3i54zKvdb4IKQ4U/3U3NqHvlbO4v6SvdUJsW0NEXarnHKfsJAJ4WAHmP?=
 =?us-ascii?Q?iZRd9G5w6XktdEvrXjzc+639rBt3WiEdZVQdpqIpaEx06bh3Ok2QpPbda42f?=
 =?us-ascii?Q?J/HPZL0e0ZaFl+3lKhOiwPCdgCfOC2L/9K19obmUh0Y2jg7a1ElFZP7aJ6MF?=
 =?us-ascii?Q?GaNWdMpPLXuwWDD7wqyVbBhm3fgGMDF+IoYkrCcN0K2ZE54IhqZqlZjSBNCz?=
 =?us-ascii?Q?X264JtiabCnfuePX2P/Xudi0y0PJgg296vkki4wkQbETSe7ttCrh0Jnldr3r?=
 =?us-ascii?Q?UDveg1WFhpoG9zkriD1IrWAoCHxgpkQEqqRC2V7sSXPGHgh+gYxLSBwteH4x?=
 =?us-ascii?Q?Smd3muhJIHiA0eE/wb38rjwSwxd38TXn0wLBsRT4/6/sYawaNrcy3W30fo18?=
 =?us-ascii?Q?aJDbh/T9z3YW6E5Yn7w7KnY+UywfBoHUY6oet1DH/cha0E2QduGRhkK+Gyun?=
 =?us-ascii?Q?gouMhpki1WBuRWlE+2QbVyfqR0ZQqN3taUgvopwnqoVR94Pc3vorg/49iX+k?=
 =?us-ascii?Q?y2uhFmc90Zber8Xk2YF83rNRt/44pxa2rt9JEa5K3Ut1Js9chHDhtbjwEOmO?=
 =?us-ascii?Q?YubcGZ5e8ltdXi0AApo1o5Txzne3ulniMXRaQd0qBTqVPsIBPe6FurySHuUy?=
 =?us-ascii?Q?ie9oKYWagUd3xjkHLjG8ySQ9WRx/JJccqm9SrBkWrNGHuwDepxazRY4JVlyg?=
 =?us-ascii?Q?5OQujTJYynbrc7sCSGTQ8/dNhPwB1hfB2J6owKn1wnUlYLbQOcvB+06ECUzl?=
 =?us-ascii?Q?ivW+Yj66JfZkpxUL7KizPBn73njstlHI8yDdVBFexENn66q/UpxNvBCi24zB?=
 =?us-ascii?Q?vnm9hpoPyelwc/SdAKKSZXD7lc/jpPx65bx03gPXtoGrMTZ4QELUK7tP6mwd?=
 =?us-ascii?Q?p0U/rTHRri/9MldKW3bBSyzQhMvKRjH5vWwwvzM3pmZ/PUf/5i+RC2/1SmJ1?=
 =?us-ascii?Q?yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4uGsARI/+O2hcdU8xflinW5Ay5PPPfULwHIrYdQXb4UEUnEVjCNNv2o0PabEmJwYoxPDQRgzIwCiL9G6ARYXGjdwdSQhQs1eQHZduAiQrSCuMCbRDSKDo2DrLyZ3hgKWU130bUN6VjkI5WzOwgZiljBfM/kH21UW62wYRKlbPBPuKqEzjXvhLd6h6FnkWfmX9cdO869LcQGymwVpEKdI6rpST4RqvHqR0GjE19OC0z/hXXCRFK8ZVRsIyVMPBwUoJgoL7EBTTZsmyyUE/hO8dWH0GscS/Fss3Q7L5F0YglKNbEeNtv6Qaw6UCb4LR1wi9Qjvn2j97STz27g0yX9bgL42CssYQ+cQ8Ts1cbFbTHMhbFKezdbtuMlnQFEGvA0pf+4InKIzoN2sBqMic8NYH0BIT4XSj7bVOtCMg+C4YjW7Mv7dIFUzRmva9dPGU9JHzRwDOWZ6PJfKrhWjxabE++zoJ4NLEcxFRkbu87o9iSG/vNj/VHVZ3rbxtMNsS0doj/6XkNqyFQ5n0fRc6SLUJKNe0BZc7EIf4qzCH0mytpgUKJQnPtjswrGOnzxJBkdxF3EZxBXD5AKill7gvzTPfD2nVgsFSekBXP5BL5BShqQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13560fd6-84f6-4da2-5cb1-08dcc83deb87
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:19:05.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Up8sVQgm9iS4d/KfpIU1hT0jLzHjsEyqsBN/vCuSt8W/w3dp+tVCAElWTLEq5S7LlUTPTeway2EMNynF2XSfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7849
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=992
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408290107
X-Proofpoint-GUID: q4khTCHTH4SpbYZ8GHKuXLktZvULr23F
X-Proofpoint-ORIG-GUID: q4khTCHTH4SpbYZ8GHKuXLktZvULr23F

On Thu, Aug 29, 2024 at 09:26:44AM -0400, Jeff Layton wrote:
> In a later patch we're going to need the ability to decode the delegated
> timestamp fields.  Make the decoders available for the delgated
> timestamp types, and regenerate the source and header files.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfs4_1.x      |  2 ++
>  fs/nfsd/nfs4xdr_gen.c | 10 +++++-----
>  fs/nfsd/nfs4xdr_gen.h |  8 +++++++-
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4_1.x b/fs/nfsd/nfs4_1.x
> index d2fde450de5e..fc37d1ecba0f 100644
> --- a/fs/nfsd/nfs4_1.x
> +++ b/fs/nfsd/nfs4_1.x
> @@ -150,6 +150,8 @@ const OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010;
>   */
>  typedef nfstime4        fattr4_time_deleg_access;
>  typedef nfstime4        fattr4_time_deleg_modify;
> +pragma public 		fattr4_time_deleg_access;
> +pragma public		fattr4_time_deleg_modify;
>  
>  
>  %/*
> diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
> index 2503f58f2f47..6833d0ad35a8 100644
> --- a/fs/nfsd/nfs4xdr_gen.c
> +++ b/fs/nfsd/nfs4xdr_gen.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  // Generated by xdrgen. Manual edits will be lost.
> -// XDR specification modification time: Tue Aug 27 12:10:19 2024
> +// XDR specification modification time: Wed Aug 28 09:57:28 2024
>  
>  #include "nfs4xdr_gen.h"
>  
> @@ -120,13 +120,13 @@ xdrgen_decode_fattr4_open_arguments(struct xdr_stream *xdr, fattr4_open_argument
>  	return xdrgen_decode_open_arguments4(xdr, ptr);
>  };
>  
> -static bool __maybe_unused
> +bool
>  xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr)
>  {
>  	return xdrgen_decode_nfstime4(xdr, ptr);
>  };
>  
> -static bool __maybe_unused
> +bool
>  xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr)
>  {
>  	return xdrgen_decode_nfstime4(xdr, ptr);
> @@ -223,13 +223,13 @@ xdrgen_encode_fattr4_open_arguments(struct xdr_stream *xdr, const fattr4_open_ar
>  	return xdrgen_encode_open_arguments4(xdr, value);
>  };
>  
> -static bool __maybe_unused
> +bool
>  xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value)
>  {
>  	return xdrgen_encode_nfstime4(xdr, value);
>  };
>  
> -static bool __maybe_unused
> +bool
>  xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value)
>  {
>  	return xdrgen_encode_nfstime4(xdr, value);
> diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
> index edcc052626de..5465db4fb32b 100644
> --- a/fs/nfsd/nfs4xdr_gen.h
> +++ b/fs/nfsd/nfs4xdr_gen.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Generated by xdrgen. Manual edits will be lost. */
> -/* XDR specification modification time: Tue Aug 27 12:10:19 2024 */
> +/* XDR specification modification time: Wed Aug 28 09:57:28 2024 */
>  
>  #ifndef _LINUX_NFS4_XDRGEN_H
>  #define _LINUX_NFS4_XDRGEN_H
> @@ -88,8 +88,14 @@ enum { OPEN4_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION = 0x200000 };
>  enum { OPEN4_RESULT_NO_OPEN_STATEID = 0x00000010 };
>  
>  typedef struct nfstime4 fattr4_time_deleg_access;
> +bool xdrgen_decode_fattr4_time_deleg_access(struct xdr_stream *xdr, fattr4_time_deleg_access *ptr);
> +bool xdrgen_encode_fattr4_time_deleg_access(struct xdr_stream *xdr, const fattr4_time_deleg_access *value);
> +
>  
>  typedef struct nfstime4 fattr4_time_deleg_modify;
> +bool xdrgen_decode_fattr4_time_deleg_modify(struct xdr_stream *xdr, fattr4_time_deleg_modify *ptr);
> +bool xdrgen_encode_fattr4_time_deleg_modify(struct xdr_stream *xdr, const fattr4_time_deleg_modify *value);
> +
>  
>  enum { FATTR4_TIME_DELEG_ACCESS = 84 };
>  
> 
> -- 
> 2.46.0
> 

I can squash this into 2/2 of the xdrgen series in the meantime.

-- 
Chuck Lever

