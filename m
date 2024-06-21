Return-Path: <linux-fsdevel+bounces-22105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F26739121C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2185E1C2152E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDBA172777;
	Fri, 21 Jun 2024 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B/0fViXA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IWlefkqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1636C17837E;
	Fri, 21 Jun 2024 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964452; cv=fail; b=QnxOvTrp30ttLMHRdWwyCeK3AQoeTpucidGUl4NEHAvuKAqTggbR1CP7nczV3Wi2q7AUJrYs3jBzvM6Ej7Lbwq/TYIEL45cOc7WwtIKvtNn411S4i9kUdYBDydE6vbCXxJKgyjw5/ZInQf2/kEyX5dw67thfJYCdsO4Ge360/Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964452; c=relaxed/simple;
	bh=g/5F0h0hL4GfF9apVDX+Crdk7zad1iBFYokVEfSQIqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fNMh+CM14l4hAJ8VVEFKkdTJxByEShkrVH67n9g+0iqBlYSEFWB/dmXPrelg2op1Wb2mZX/S4rVmcuyBHq8P3fTqqa+gkA1m8e73r44j96web+PlQIOzordVvWpwNP/9yjrV9hIzPraGRK1krdX/yXFW7sk43QhyrOYaqbqNLDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B/0fViXA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IWlefkqB; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7fVW1032374;
	Fri, 21 Jun 2024 10:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=iQSLG0sBSRHLRNlCCS4+s9Ylgn0wtVJ0VDVh5KcEyys=; b=
	B/0fViXACUAl/0vwOxcqQgymBpYoLJQuKnpQeP45OtxEWNFKrkb9d2nlA1P0OkEs
	W7/E9KEgfcNiBzJuFpEvYhA6i21WGLBy9ufvAM+BbOd1TEAbI1bqhJZgke9wMIZo
	X7jNNtrIEufY1Bd3wcLVMuG+lRfPFrAbOJOknqxDUIbDYTvG5B+7w4jsjhJajbvx
	xPY6xcTjG3fVVn8hWUGB6RV5ynMgpWfSSwN9FXZFbrgSZYB+9u2ZMdEVHW+YqB/l
	hGqW3biv7zw9Pns+oHzAN2V0lSeM8bn45GzLInMXHkVxmGU5K+MvmHWkl9doabF9
	4oLd5M2dxiPS5zdjSADZRg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkj1fd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L9OIFt040028;
	Fri, 21 Jun 2024 10:06:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn44xxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhoGOg27HxGtLuCOEC3yln5gkvZqsYGBii26JG3LH2uuA2h/l+Xum/oKKQsGlgtDUPbWZ77hPqayvnLgLtLwUj3k+twKYRwIfqZzKam2ZD58RQ4lw/Xp0creyEJZ2wUroIO4BA1W96qzf0V6dpddM07O1tNyV9t1ERMNBFaAyleX0d6w9YOmuodnltiaCzk8PqZRuJTZla1Y3T19I7OU0fvCY5mamJ+ArFL6HOMZXajCqgrACkQEwl+SkBM9+lttDiKsFxRkN34VnDsGXrupy/V0SsbkABbFGQ3WokhhV58fZjqmDevQFdrgaSyXE7bsFP3ylrgsDTMK4I/7+uPkEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQSLG0sBSRHLRNlCCS4+s9Ylgn0wtVJ0VDVh5KcEyys=;
 b=DJjjmnR6O5SgY41o/W1Y5bTifgHiTwNS6V2xo1y/ZfQ0R2mlJ9Dd9uCLn45PdfyMw4y2BjAvy6h+RBkfcPBgk809Yt474oiRDb4uJFXhX9H5Bn4Dllav/h+c6p+FYzpWdFHHjdqc4ebxfu6WThTspzCtccLp2Ybst7Hl+sVYnO52iapbSfLI48/jBe25DL3wFcd3Lw1KgO87wkqr+5oQo8mFiux9VaeGcZB2TeIfXS99U5OsOsaZS1lgIeJaDB4WBM4TM2sB0HdChHcXFwu0sl36DwNKoEZoyU/1frrHHwq1mCv3V2+CiqPiDN+PLAV6vLGjgJEiGWkO1y0Z7JR5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQSLG0sBSRHLRNlCCS4+s9Ylgn0wtVJ0VDVh5KcEyys=;
 b=IWlefkqBULa14rlgxGaERMC5VmZxsP5/rN7IvvB+YxgBS9h9MMhpRLqqpY5MN0P8zdjpnNNq8RXITiGliQCcdYOsmz5LN8DXHepCQQksGj7E2LvEgeCWaw2imDtEMZaHeX8yOLH6Yc7Qck2x/i7mQAcTWfm7s4Fc9QqJDds92XU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 12/13] xfs: Don't revert allocated offset for forcealign
Date: Fri, 21 Jun 2024 10:05:39 +0000
Message-Id: <20240621100540.2976618-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0017.namprd13.prod.outlook.com
 (2603:10b6:208:160::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: cac7d4c2-b6c1-4b98-e9de-08dc91d9cc02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+/s9mLkRU6HNZz3fpqj8u7cWf5956poux1D/z+PUJXguRcgqEoto7MjfnZ3/?=
 =?us-ascii?Q?aixuJX4+vj+zpb4CGh+TWYyzni7lc0LznXu1w3GBTP8d+uUlxFkN/lIqDTQN?=
 =?us-ascii?Q?ikXHbHiQA9WOH4mwfiUVnMY6p2pjy6iWrq7u+zkWID3T9f7cL9bzWRZ3xHUM?=
 =?us-ascii?Q?v9VU9Zsd0DZJJbgqc5HcFqN61UEdIKDBuKtQrZQNIPQu7BPQXYPrwz3KsZj+?=
 =?us-ascii?Q?f24EZBAeICRoaXWw5hukPES3ngBInrtbF+uzRgVF97sCuwJoIn+MBEJS6ATn?=
 =?us-ascii?Q?dl+P7s50mcj9x2U/IM/IJSQW/MMBLws8pNRHvKnymEAmhv45gnusAoEaapf/?=
 =?us-ascii?Q?i5T7IXYYaB1c9vW3tEh19NUT1zY1GTS0PFlvOYK8Ynr4cOFSeSciLZnLX1Qr?=
 =?us-ascii?Q?WzaABITh2MGZccH3m5wVvVUKNlJlAtVFo+juwBJIkmippbod+3NId8RgfEYJ?=
 =?us-ascii?Q?LYH2NOFhLfIP9EFwlhBwRkAonhszeShvqJ5QvbDpo/ORtKQqWrXXY1QXt/O2?=
 =?us-ascii?Q?6RIKdW10sPmeXqFgyugvD1j2RilSmFk+XL5seHiLBQLCO+fTdH2AVjv9Go5U?=
 =?us-ascii?Q?t5DUd8Bw+PyDfdEkKKqHk8caIdZrif/DbXD+B1voh0xbxQqyq0/wY9XkLFXJ?=
 =?us-ascii?Q?W/Y97zp6KQ1ifVN/NTbiysR+35LOW+aJDGhgJUIGkAyeFfrWbknjKT6Y0dYD?=
 =?us-ascii?Q?R+3gUKwQEErvZjSINsnDbzTsSVeokZC1Uj/uo4lhyKXE21m7W1KuW6peGZIW?=
 =?us-ascii?Q?QG9UU1UQe892BzcY9HNuOGM3E5BU9Io/MQ0MZxLh3d/S/ETkYYfN+IrrmLCB?=
 =?us-ascii?Q?jFhN8g2/5Hl7/Y0YWqzO5nlAHl3gAaZgMNj6xm1fLtTnq/4OEMyFIdpCkaVP?=
 =?us-ascii?Q?MyE/Hi+21j+bctlHOFsw9gVQT1ubqhFCt63iC2xpE6/Oft3a7LCqsdIW4UXT?=
 =?us-ascii?Q?VHgrXKA1WmERhgy7EmgMIyWyZ9O1Pr5H05oGy5s1A8Gst3yn41j142WvN1pb?=
 =?us-ascii?Q?PuUHVeYP8w9qcIWJOQk4kHaoLFC53+n69oXmdjOTqWzDpMMtr10civEm8BT6?=
 =?us-ascii?Q?QUkYwvzMlwa2nlasdKzJYkZmPvMH1kKnV1ZZ0pxETU393OEXEvzue+cGcxz9?=
 =?us-ascii?Q?FdQX+bRh70Ulyh1fIA25jdSZio/dtocO4/xA/ypGllhRGNu0Ua0fdK0RTi84?=
 =?us-ascii?Q?YjpJh6odCS7oGXpR7FpjsOpTeroKQfmJ130xruJM0YbEDd/3nma+Fc0qtiHu?=
 =?us-ascii?Q?Ubd5Jn7BJN0pDkAYAzUeee+KzWEIu+nr9JJyH7QX1zAvkMdtx9REUsOqYrlE?=
 =?us-ascii?Q?qF5p+leAtWdSVTBYiYqPwC5P?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pVvS1hMiVlkOTqqatzs4ZoXzgZsXU92dLVqoESZD/ZTwEMaVTiQsHbnV+ZLk?=
 =?us-ascii?Q?eM1JtD5lcSDJE3RPELokn/daDa8jBuOd2Na2U2CoMrwvO+M1JMUahaCFzDBu?=
 =?us-ascii?Q?WT45bmzPeQb0h8LlVK57wllX02lHMOGY5j78QzPU4J2QuyU+7Qqv0coxfHiu?=
 =?us-ascii?Q?b7EPLxANCK3cW3CGyqc+Nd6vfuJ/fjnkie8kTZLbyzIERxljrvJNun09ltic?=
 =?us-ascii?Q?p1E6jv7StkuEVMoB+UbQaovoyQf9HNASDPuMNR6EVf8WSTYj5zS4LodIe9RG?=
 =?us-ascii?Q?LjLp54G8YDXo17xARGCbX68yttHkH4Gza64B6Tk65dJB5064sI88oVnqcxeS?=
 =?us-ascii?Q?C7KN2As9wq2i9Q8O6MkCp33m52gIcJxV7y4sBSC52x4hPA3wB529RfG/iLsE?=
 =?us-ascii?Q?sD3KFRtz9kGLMvjEsd1DoIr10ZI87EllGmPjNjXZyxt+8twWfRRRzrskvsar?=
 =?us-ascii?Q?24+zZ0jtaEAEIhvdOr16VNP0ZZZqxwRq9uFPKqNiYH9hWJjvb9bEeQ5UBBc5?=
 =?us-ascii?Q?6/SBM+Gx/4uKCWewlE5pMKrhCYXaN/u9XXY4Bp4CPMD2+n8WERC/8yPcf8oM?=
 =?us-ascii?Q?mqtIhsq/d9fp6+B8wHJHJA0sx2yso1DokYvYYDRBIbfpsO5gBojxNJz9PT3B?=
 =?us-ascii?Q?6g3uMYLtJvdxMdRu2r6Oxzlqq9+7RrP+dQIYwtjLOt2scFIwb4mkSffahee8?=
 =?us-ascii?Q?hEqwnisqBtoxP9IpgM2cHvljE3KUkAf097KCtAREVvKK9OvHfl3RMF6VSJRM?=
 =?us-ascii?Q?HV/RHnMu545Ci7G70JNMe5saNLqfo0LvP4Qq9P+eUsNlTXJlRnrTu3wV9BLi?=
 =?us-ascii?Q?6hyktjQDOyRc/Djd/92NxEhmn5XX1Pl2cFP/JXqRQ25lDvx15x+CQN1cpiWU?=
 =?us-ascii?Q?XvvAGTPivNZvq4Vvq2nIr+45ScFtaMu8pBugSQgTWOTemevq7Pp5j181ad8m?=
 =?us-ascii?Q?SX0xG6SBNvkL6dKnprTlG4VgHGs1tnSFmoWSajdz9ouNB3zGGVIAhMfQKYTP?=
 =?us-ascii?Q?BQJggTrxsNBctFPIe2bL0kVjLXICT87f6Rlsm5zcOsxnNkgSmAfCPPVFt6+H?=
 =?us-ascii?Q?8EEePIOZQoy4p1f8AemtKKcjZSx4izDXcon0iXDnN/NZm8y6To8uOTCGFTI6?=
 =?us-ascii?Q?ewabkw09dXBpnY3XM9pjOygMz76xcFLAG4p4JeI/ZHwWpKejrbCOcKBVcZaJ?=
 =?us-ascii?Q?jnNP8dawMWI86lqTNER7XKAL8RneVx5chfnARYexnHHQzpywnftOj3FcHK6L?=
 =?us-ascii?Q?UU7Ic9qNI219PAkl0JckAYyb7dGZ477nf1TEblXYW/7+Bjmq84uFHCO6qkjC?=
 =?us-ascii?Q?tw6s18m9tQLBdBcNcg3KDI4bNYMaWlvWNMRnT8Vx9XjTGUvqkn/2x4j3zS+H?=
 =?us-ascii?Q?b4lwnYmuzJnNuIXSJ4Ai46fXc/yFe9koz3yoBAZYCjGMbizRZOOF0Owa/296?=
 =?us-ascii?Q?mHtNBFmkkEIcerS6vOq2Fy5ek+ZFnL3WZmnL/sPVW/vz3WW5SZChDLU7HSi+?=
 =?us-ascii?Q?F+gKx4ViZfs4SKNhWw5s9CZ8bEYfx/04V4hFT1f1YS2UUD6KGuTez9GkOxh5?=
 =?us-ascii?Q?eBBtdt+y9TjxTbsCzsUqCWdb+OvzenJF9qwdFr5qo2S4BjoGVJAkdfYNotY8?=
 =?us-ascii?Q?eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H5g6t6EqQlvOxt9aOkfzrHvItCauic+WTGaXqPkjV8esQJAtwBpiPqGWncCENbg/aLhvjGdBOiI+NbDM0TfioWFxezwgYKTUCqAtuDVy+WAiGamO8SkAp2GClnUwL2xDj3S/dHDYV3uV+8i2J4uBOM/zZPdUAfIJUG1Z62/6l48/JbPuvYZeQ4A4bn3U5FBh8h62wDSl8bim2IuNyfU0pgI0RSJ61D6RxXZPAkW/mfVldFZZSckmTwHlFRo5RDCM3aV4YCCzdj+b9VBy82RGQ1cV0oGdTfcuMTcG352zkrOlO0hi/OC1UmQvsH7CjKEXAF4cc7ZHz74lq7gttI00tn2PQ06RQ1THYjbX7gUT7ia7i3ug3x6JRFQ38JEQsFWc/xo7UTWQQcYfq2P5LDDJrJe5sKQYx+8UvFAnVtUd0ecUGNhQbT+V2qr4oe2ys8ld34WRP3AjTDjV72Ir33wlhNHt16n08mOkjqEb7JFjOuyTou5Ko+5Ur1IBz6KGjIKp458LUmvYt+YkBAMdN4hediB5u+Hd6ZmMEum5x37vrNYptYs7/QhVUs+eLKYC6g8Y4DYgsqKqmeTEBuiZuXzAb80b631v6g4WrOxpemMpE/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cac7d4c2-b6c1-4b98-e9de-08dc91d9cc02
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:19.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 30YMaHHQBYHnvgz3urJcZ7DZqoxR0hib0O8S0WXymmaVwp9cc+qYp94NWnqFOwNwYatpvZmevvNAv+qQF/+yfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: tOlMmAXWDiTYnDFgCcXXidcm0bzWeMF4
X-Proofpoint-ORIG-GUID: tOlMmAXWDiTYnDFgCcXXidcm0bzWeMF4

In xfs_bmap_process_allocated_extent(), for when we found that we could not
provide the requested length completely, the mapping is moved so that we
can provide as much as possible for the original request.

For forcealign, this would mean ignoring alignment guaranteed, so don't do
this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index ebeb2969b289..42f3582c1574 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3492,11 +3492,15 @@ xfs_bmap_process_allocated_extent(
 	 * original request as possible.  Free space is apparently
 	 * very fragmented so we're unlikely to be able to satisfy the
 	 * hints anyway.
+	 * However, for an inode with forcealign, continue with the
+	 * found offset as we need to honour the alignment hint.
 	 */
-	if (ap->length <= orig_length)
-		ap->offset = orig_offset;
-	else if (ap->offset + ap->length < orig_offset + orig_length)
-		ap->offset = orig_offset + orig_length - ap->length;
+	if (!xfs_inode_has_forcealign(ap->ip)) {
+		if (ap->length <= orig_length)
+			ap->offset = orig_offset;
+		else if (ap->offset + ap->length < orig_offset + orig_length)
+			ap->offset = orig_offset + orig_length - ap->length;
+	}
 	xfs_bmap_alloc_account(ap);
 }
 
-- 
2.31.1


