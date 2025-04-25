Return-Path: <linux-fsdevel+bounces-47351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E192A9C6A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAD27B6197
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EB32417EF;
	Fri, 25 Apr 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFkzPlsr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6HgP5Lh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43B23E235;
	Fri, 25 Apr 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579045; cv=fail; b=SwqXr9tZzHce4jDtZS1lXTIICGOCOe/zHHTORNZd1KUye47sLwCkTvrcfxsnC/MCPtQ+XKIJuNMtgLuAPWV9ljTr2jdvS2dysfIfR9FpG0AYEGlSm2PSTzQm4noWBWFDEkqlIPVyQnTW1nmTKu+F1MOxaFy4hT8I4CFVQNvogKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579045; c=relaxed/simple;
	bh=YtY0xhDc8wMBp77loeboQVYATTGdEiTzHG9G2Yqai4o=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JGxHa9k+f8ieDqir0wPOLvs6FJAhgvUZB56ncN7UMHIiIitXMQ4JZXQKSDm/HLcOAAtPHnDbH0Z47FalPUJKe7e04cfSQgSGy4k/g+Dkm7DMJWa0vxXxqau+X+JkdrN+05zmkxFmhw+60sWHXM73ge43/hBMLSKgOjQWJrt+PeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RFkzPlsr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6HgP5Lh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PB20wJ031051;
	Fri, 25 Apr 2025 11:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JIuqLbfbq3uQXG084S
	sGH5oCOZZYMGh1qvne8FvY/34=; b=RFkzPlsrzGS0IuvftniVC/PvRtWOmvsW+6
	7JCh/vIbiWB3apTLve/pCnRzKdxdsTRm45yyZNL6szYvQLOarRF2IF0B6is2RZJA
	ZelmbbK4+1CeIWC4qejrWG190ivSO3l+rMiCosbRhrqbZQ/JvLbhT7oGhQPApFIS
	Z0rd+cG0/8UT+73UdVsbsITVfHS/0O3Hqt87ZtmjKEIojGCfRyc+zABBvDToLt5A
	C8IxA7OhAkkPAQKRCrxYIy+tGGqI8z0MaZZJbAIQe9lVze/Qw3XBpKVFO64yr8Ca
	AMilFwvkDcJyJzBUp8nzGsLIaaiLa8xbMop55xPHqVcky4jz7d2A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46895kr0v0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:03:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAx6Bl030859;
	Fri, 25 Apr 2025 11:03:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08fuvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:03:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=egliuUmuxc/OCbK07fMKOdPChIjvp2JmX2A9YXKtrV+NLrvaF47o6sAmRfxwp0iYHGG0mVYHXjnicCdLC6GeSoaRPzNYQKnOzc47gUxqJXqzvCagxF5EQqbaWN/DNJis76pjI78Is7NdBqcUiOQmkvQ2weslXF+CmDtwL+tu6ZDG4gUCQKEVtp4DfHERar4yBOECQE1lZ1/2jHAOAgqViJeHyoxTVTzsoa6UCOqsII7cImJo0xsVgwhq8cZoSlk5Tb3k4aMUKZpqEuM1dQ4RQA4WjmZ1Op2lnOIxHBxC3YITBfTjxlbv10ejn+dOPUckh6Wb9JBEPSBTxcGQfu9nAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIuqLbfbq3uQXG084SsGH5oCOZZYMGh1qvne8FvY/34=;
 b=RRMxmQqF0K1H+mBLx8Xng1QYeiS81ZM00r/S0TFT2VjvMzWy7k6gd/Ko94WGS4vYUjbDfan4QTNqrj+f029Yo9aSiLry8F/xDL27yBcfUednLg+p66IgQJ1VKrYfi/zKR7AhYSSfne6K++BjyCwX14sdNLjnEkSjtv/PBA+hrKksI05uTl3NbUFRPmRp7wqBc7lxgbbmS20cTFV2bAhcU2P2WTtQ0rwRAmOsbLVQf3BuJdFsyLaTOA76Fni3F64uQY2Sce4rebxalrHkYVCc6DIiFqeu/jQcerog9SVliTdGEPMiecQ24TncbJJ6gEGQdzsxupNBx9/vDZqgezwPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIuqLbfbq3uQXG084SsGH5oCOZZYMGh1qvne8FvY/34=;
 b=w6HgP5LhcGKUWk5uUcQIY1nZgXRa/3D0B8ZxJDjWAoIoODrTJ5RnjJqXHWsjsNinbkqW0VByijQYBusS5656kgdzyal1NqFw9Lwki7V66VIZLQ0uJOA+IENZkKNGtwZGqe9sc+6yl57YahooJTOoNkYpz5TfUGB42XyzL27MYRs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB5205.namprd10.prod.outlook.com (2603:10b6:408:116::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 11:03:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:03:45 +0000
Date: Fri, 25 Apr 2025 12:03:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <12d3a287-6e3a-461b-a756-e9d980b0315d@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
 <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
 <14616df5-319c-4602-b7a4-f74f988b91c0@lucifer.local>
 <80c17a17-e462-4e4c-8736-3d8f1eecf70f@lucifer.local>
 <j2yh25inlak4ra55lfpiwl2cxumrajauvuwqs56ebkidj33hxm@aob3bnwmuaei>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j2yh25inlak4ra55lfpiwl2cxumrajauvuwqs56ebkidj33hxm@aob3bnwmuaei>
X-ClientProxiedBy: LO4P265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB5205:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b6482c-68ff-487e-2ace-08dd83e8d8f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LKVreV4N7Ma3PILossJfsyushL97nff6gZYPYVRHgVVPUUt+DU2w8514WNdb?=
 =?us-ascii?Q?U4WFOlzERtT4fKnpOGjPdV6zDpD4D5FpejBH7IkM+Upf64DbzmU63ynw+0wg?=
 =?us-ascii?Q?YtzKgzNcCdww4XRS0JgDOB/0Uh0FNK/UnN6eA9sy/lcPaLdYS2Qa2kurrYlM?=
 =?us-ascii?Q?RZ44s2Tj2QgGF24o2calND3B95s/ynqAASfvoM2+lidd5TYn1phAAzrm6hnf?=
 =?us-ascii?Q?YjQ4qa7ugQBPrSHOC/XybvjoqnKp5WRCfMkCAAurJ+nl6ensgKA71P1jeuD8?=
 =?us-ascii?Q?NMdg0t+JjZkjMdyDPmuTCmGFBU6WCFOyxuirU26i1mdzJh9laPXQZ3Ltx5mn?=
 =?us-ascii?Q?VR7ua9Z3rv9KBx7fwbOJVvofSmSSSIYYQRBHOIVNZUxTu9T5kveoSS30vH/D?=
 =?us-ascii?Q?MagmTUfj9y0rmS94sJkOj/b46g/6Ph/npH/N70YVdORTUqPY8qqyFJvW3po2?=
 =?us-ascii?Q?JagxtXZh1CxDAKgLBgws9mwd1OqUH/KZ9Ohug5+Mg7v7bUwOgLBe5zTZsJtJ?=
 =?us-ascii?Q?1yA9gz5o6CEGLS5bNNuFCZXd3LqIo27+CI8zyXVPCJ12qy2CltG+LcR3JGwM?=
 =?us-ascii?Q?VMq5SM9MlR8l8MUG6nSDMMaa+nm2JnktX6IlpBYhsnEDVpiNq0/9QqfUj1mM?=
 =?us-ascii?Q?7IsWYHYlvAJ4eT6fYbwx/VwTph4y1mmtkf21PtYQElMJ0WgUogqVIWLrGByN?=
 =?us-ascii?Q?91856Cz+p4YkNrFIy9TGGY/GJVMeWIPLVCKVdxHD08dN6uZhVLlhY9nc8xFv?=
 =?us-ascii?Q?R7SsPn5K79HAHe1vuMhRgzzmtwzULv2qtvUyM1yShiwJEH95ycUtsB4Emqf5?=
 =?us-ascii?Q?K4zAXb9x+BVZAWWspJKOGBjDnBE2gO0JK2riA+zsKgmZjYzD9rhikcY6q/vL?=
 =?us-ascii?Q?u2vNznxfGgOASVtquFtF4QCLYhOKNBSYRpQ/sO7OSiGgelS0DxJsZOmjJHQM?=
 =?us-ascii?Q?BOjdTLl9hH/P1j1tV4n+Gr1OGWXZN5WhkGhbkQ6K49ff51c52MI+hO7ibF5N?=
 =?us-ascii?Q?M2A1D1GDUc8oD2UR473K/Pi0MbUpZH3EoPY1PVOmqq3GqVe1whgM55pF1SjP?=
 =?us-ascii?Q?XCF+MazIUR0ZmcYMLt5821xlcKHDIcUmsjlZwQl52uDryZ7piT5NsJNA9BDe?=
 =?us-ascii?Q?8FO10yRtkIeJZ/6Kb+/dssxWmHuHjtRytkFKm1JMoPALYtOv4Pg1/hkvgFJS?=
 =?us-ascii?Q?eTZHlCcALkaw2jntaBWWKN38XM4gEiVm+gLhEDb30r1eSMrR/p1+PEeIjQ4n?=
 =?us-ascii?Q?JtEWimDE2+AwiT2ktN6H/XGRfvwJ+gq6hPS1n6r5+6/knA1CiITokAcvdnmh?=
 =?us-ascii?Q?X4MVsO8zcVoQLxqr+PeIB+57QGgBGlv19qkt0ui4/x/LoBwJ1ZmoGlHFuDr7?=
 =?us-ascii?Q?XXZ1YO0yM/SxJ1M9kD6TJMU1fKwvdGGZ3JqX6gHIC66NKBzZAzqzcaPiqk+9?=
 =?us-ascii?Q?9nxZ8krXZYA6bB1KBZgA3HHcNDX7wovNaiP+PDun+JGqtsogyWdwFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZHRB8Ff/VVTD85vxUd2AXye5HFKyet1tlZ0nAJe7RWg0aAjcfKlGwjoeFdfI?=
 =?us-ascii?Q?za2xhD8aPySmDwPbwNu3m3w2lyX+gbZhG9na2ULJjevcwlI6fqMzPsanONdo?=
 =?us-ascii?Q?K9pczpXvuQqtQ67R3hKaopj+XKxsV4QmOtjlSdKCHZtRbjsg7KAI0A+B4leI?=
 =?us-ascii?Q?sSbFpW53aHusxi/gdO2JGRG8hDZY1wv9u270RC4FAKvROY2/qEmXxTt9KWYz?=
 =?us-ascii?Q?eZX+N3BZ5OtvOQHuHmANJJ0aV78QhaBjZkvH3MvbqomCBetjAettyp/J1PUg?=
 =?us-ascii?Q?jM5FqDT0VReqBnspNeTEAFyivXQwZlp6KB1OjuN2UWLSfmkvfSVIWVZQQZ6E?=
 =?us-ascii?Q?EHgTmIqBQkKuSomLSTKX7y3qV7JfIPEWZDumtqSV2vfKpatCOpOx4uGYC1tC?=
 =?us-ascii?Q?EMwIsiOXzBBp142xqKq6wZxHn847o45q6K36M79vUeyalWHvn+0u/4vnF/Ev?=
 =?us-ascii?Q?J7HXHPnO82gEQl3AzaWovvKFb33azuHaXm+0fj/Qeu/PROPLDPp0wN6HNUt/?=
 =?us-ascii?Q?ZNIpXkZ2skp6trsOWybYeTSohxOJdm/zCP0hSDYTsG9zBWvoM/dVhWiagyJm?=
 =?us-ascii?Q?/J1X5aYoVDg21n8WifMDlvcYSH87yfOupiSx3NZB4IBC7RIv8AeP080ezIvB?=
 =?us-ascii?Q?FlZEEUeVakeuJxEMbWBIMw2HITMucx3JFJWRTCqJ5ylfxrCDc7AS+8uF+Tye?=
 =?us-ascii?Q?MCG3oUuRwuW3eNlHXgyS75uAPGsrsypPOth7ksIXdyis+8pFJNHX7qeVu7K8?=
 =?us-ascii?Q?jsBfJPZ5cEfuiTKltevuedangoixr6L66fqKgtwJ8IsXV5d8Rwgo7XakeOAG?=
 =?us-ascii?Q?7QDP1vx3+X4yHmYWsMxxZlbQl9I7Qf8qFXMpRdjWoB+M0FOPOp8hbj+CxMHs?=
 =?us-ascii?Q?mGIfMVg7nMQADIx6kWNFpaWv/mKZBhkKU4f5+3UVyT+6IRId3HCTbzMlyksq?=
 =?us-ascii?Q?r74ukS6mV2Knc/HJP03GxqEBqDyMtXTrxw9lMskXhxx4HT5EkbB5djOSnd6n?=
 =?us-ascii?Q?Pny4cT0xC7sLaqqhrPoKzToAnSJ8qBkZecZCeW3wYChpSJBx+Up2qQ6FvpRo?=
 =?us-ascii?Q?CKjvTkheALJbrtsX8LzfM3HzCi+neBUmqUalSHxCtNoPSSznkN4fp3UVafcV?=
 =?us-ascii?Q?kyEPslhzVlRtcdViAW4OTSIEUHjO2dPXJ8H/RtTIBPl6NILf//wVFPVquqRM?=
 =?us-ascii?Q?wLjN3xKJcMo6BvIe8yVTe+AZ9EsnKJHdOxDW36FxAhXeX+UzFF3b49Pr3lZ5?=
 =?us-ascii?Q?vy7gqEixfAuv2UYJDcY+JAcCVniJH02zTjrQ2Uu3nPl5rs8dTyE3PdLxdIBV?=
 =?us-ascii?Q?BWSD17mtvimEnlxXYsihoz9eshEtZ3vUXsNYLLeF1/n9Elo9fqTb1tHwYAeN?=
 =?us-ascii?Q?bIjKuVjYMJ0XJiEmaGBNrderXZWqcLHNXFrOaVGEmDL97WoKGINy9YXZJHF8?=
 =?us-ascii?Q?f0tuM8Q+aSt1BLVMQ8OM0Nw1zY6woRvrmkvrP77a1k6FC7C06G9GT4OIKl32?=
 =?us-ascii?Q?A03/sk9m0UKrKnefof1IpHi5hTJ/JmY7AWL85WZiJpEkFNz9dZUpRpAz5r3s?=
 =?us-ascii?Q?t1crEZULUqhCc3chMIt9LaN8qyvdV+vR1I9hJmDxnoFRPQ265vWPh/CAGfiT?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Kffd1KKSA1o1edJluaB/+gwwaBnFaJpZ5vU7WxTrvmlSzudppPO2RPxSnFaUYk/Z5mXk4oyPrVzmSxfjtcvOeWBZY+fteyc+ZF+hWKgqVbullqt2OgqPL94gIESrO9CWehGHNYfavqReDg3c7HCs725FnFgdkl3qS0LpFLsyKflZ3w96z6I2tTAfqteON79cYYumI+OOyOEt46QIBoSfn/Hh+Yaam1VMMMkoBVE4Nlh6yccFXKkKKVa8qE3q6O74LHtzaNmNg0LQZ2BEy13gMYMeyMXmeaRt4Oc3oU+9ht7BUpaebUZdsjC5Pe9SlvKtIujVn/2SwSgssuuPmwMJZnLA0R7BmI6qvsraTRmnT0Uxz0uFZj3tgJlt1tUGpQe3Cc9NvOuW+m0XvaJpNhGWOstJaSE+WBfhJBsTBIjXavc66xfyjsVFI/jmPn070O4CkkOCen5XfZyXYwYMbzlNrBy9Xj8qfNabhSOecF5HTnKxYK5EQ3J6tLC8gSPSLz3brvliDo+4Qx+e97toORCB+qJaK2SityKkC1QQ8pgbHmn9hfE4H/+8o4yICFeq8yJrsgiV7fixinQNW9iLDfktQWXefOyEn2JyLEjyYcQsWzE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b6482c-68ff-487e-2ace-08dd83e8d8f6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:03:45.2822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I++wsheQYsTbmFtJscqrxMY+k9yTmkpXEKvEcA+NRrVAKgYZI+jhF4/buiWkntcYIour9o80XAJJTjyfOXn/0ZQzfxb9RrChyFSE/IT0FRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5205
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250080
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfX4hjunmn1azSX +lpPA2JKXv1fQcdq1be00xps19vEP1vHTgfd93XJo9m8ijHZOSTGYiYrSr4/86fQjM09zS35Kxh OzR2eVo+MEVhBqEGHBHVWN/7cI4UnJP9rEtMvrITbUmSdsIq4dw3bvYoi9l3WrLVDFmhGKAFK7l
 a1xGqehESBia1aZNoYucdOF4QtcNjyeSDlr/8KjAbpJC9sB4ZOa/KUG9r6XhzeuGKuGK441rS6b d8eOkEQD/4a0Br6Fq/YP1AumxUiYQa4tSoqtQAxRmo2YhKgZsAUi7ZbpHRi5CRRxvpV7mZL7vzx Syj23FhyCciJbISGTolu6p9IDBVmBuH916KlQec4cgwrhgbS6n1luc9F5fTxGDaTncARQ3NWbEP pwUZE2T3
X-Proofpoint-ORIG-GUID: v-y8VJRE_vI27Mu6Mhl5UAQZ6iwc3Wkb
X-Proofpoint-GUID: v-y8VJRE_vI27Mu6Mhl5UAQZ6iwc3Wkb

On Fri, Apr 25, 2025 at 07:00:27AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:45]:
> ...
>
> > > > >
> > > > > I think doing it this way fits the patterns we have established for
> > > > > nommu/mmap separation, and I would say nommu is enough of a niche edge case
> > > > > for us to really not want to have to go to great lengths to find ways of
> > > > > sharing code.
> > > > >
> > > > > I am quite concerned about us having to consider it and deal with issues
> > > > > around it so often, so want to try to avoid that as much as we can,
> > > > > ideally.
> > > >
> > > > I think you're asking for more issues the way you have it now.  It could
> > > > be a very long time until someone sees that nommu isn't working,
> > > > probably an entire stable kernel cycle.  Basically the longest time it
> > > > can go before being deemed unnecessary to fix.
> > > >
> > > > It could also be worse, it could end up like the arch code with bugs
> > > > over a decade old not being noticed because it was forked off into
> > > > another file.
> > > >
> > > > Could we create another file for the small section of common code and
> > > > achieve your goals?
> > >
> > > That'd completely defeat the purpose of isolating core functions to vma.c.
> > >
> > > Again, I don't believe that bending over backwards to support this niche
> > > use is appropriate.
> > >
> > > And if you're making a change to vm_area_alloc(), vm_area_free(),
> > > vm_area_init_from(), vm_area_dup() it'd seem like an oversight not to check
> > > nommu right?
> > >
> > > There's already a large amount of duplicated logic there specific to nommu
> > > for which precisely the same could be said, including entirely parallel
> > > brk(), mmap() implementations.
> > >
> > > So this isn't a change in how we handle nommu.
> >
> > I guess an alternative is to introduce a new vma_shared.c, vma_shared.h
> > pair of files here, that we try to allow userland isolation for so vma.c
> > can still use for userland testing.
> >
> > This then aligns with your requirement, and keeps it vma-centric like
> > Suren's suggestion.
> >
> > Or perhaps it could even be vma_init.c, vma_init.h? To denote that it
> > references the initialisation and allocation, etc. of VMAs?
>
> Sure, the name isn't as important as the concept, but I like vma_init
> better than vma_shared.
>
> >
> > Anyway we do that, we share it across all, and it solves all
> > problems... gives us the isolation for userland testing and also isolation
> > in mm, while also ensuring no code duplication with nommu.
> >
> > That work?
>
> Yes, this is what I was suggesting.

Ack, I wondered if you meant placing it in some existing shared file such
as mm/util.c hence objecting, but this works better :)

>
> I really think this is the least painful way to deal with nommu.
> Otherwise we will waste more time later trying to fix what was
> overlooked.

Sure, I definitely understand the motivation. I resent that we have to
think about this, but we do have to live with it, so agreed this is the
best approach.

>
> Thanks,
> Liam
>

Will rework series to do this and send a v2.

Cheers, Lorenzo

