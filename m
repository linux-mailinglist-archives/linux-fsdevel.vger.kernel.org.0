Return-Path: <linux-fsdevel+bounces-11430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC98853C59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 21:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7891EB2170B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4455B612EF;
	Tue, 13 Feb 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dej3rK7n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fixnuxrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2C858122;
	Tue, 13 Feb 2024 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707856847; cv=fail; b=Kt67saPgCdDOJ1l6RL9rBpbyAiUAeEslq1NZfH62yxSAN2uEn+RLEad25atIJt/41AcP4vdF9a3DO1rRPs0nH1o3P63hLVUQKgJRZi163t5b1yU8u7HicuAmKuoq/KzG1ltvfmdwBsK7RJcQgWHNWMJdADgmAiNQ1VcSJ09zEOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707856847; c=relaxed/simple;
	bh=qrLPCD0Nf9I4Z77gOjeWAjbLLYVP6xHhY3QQ84fqvRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O4HRdXaJTLyoRd2I1gD0ncX56MiD0VVSpwcFXL9Vj9oQLrXo6OudBM06jiiQXeA5l+EaLwkefoODkJ5qSMhWhP4yANqDAoaJqpy/UWpJo4eHmIUYA/gWM912By1nQwKghQr4sJxOJudGR4+OxL/pd6sSs8Igj7+61szN85FlCjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dej3rK7n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fixnuxrj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DKXxAw009657;
	Tue, 13 Feb 2024 20:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=06in32XoVAzynwMUVtypK39CA81SutdZUxm90UA3lbA=;
 b=dej3rK7nZLGtCNHQrICqUFSnfdHy9oAEns6V6U/H1m47mwL7QV5DR7tjIvNp29/irpIh
 x+GPBGfiIE4ow/jBAhtbLPGIxTNjHN0rZdKlUjIPs0u4fWOLBbGj84a2c8nGsxulca2X
 RTAg9L/vuiGF7GDARK8S1W9qFGwQLsV+FKxyt62bEh4lHpvkjl2mUOOrGJwSqpYDqC1d
 UAJpQEk0gekxNlVRdBGg6LZ+1rdbfaJ/GwjOrwttS2pcyeAm1aNlbWcvgVS2sRztutt9
 D5ybQeWKtGQhMbek04npqoj2wlajt6A/H9W5xakUKYVkgsre8NmhVbt6xrOlMiblQpZ3 XA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8f5dr2gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 20:40:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DJrJfM014990;
	Tue, 13 Feb 2024 20:40:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7ne9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 20:40:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2ECEw3yDM4FHL5IJwob6bShRlGbD6iDmhzk7NyOGr1o/YFuSWS90NbgqbWh/V2deDyzGmlsqKxJ8wjTI5zmpWY/rXVkgyFupmLcNWHW0EfACYLqtUgcavafO1XcOQo7FlRZoN07RlXZGnr3/gXnu4Zbw080gtwEbrVpH0fBKwlsc3UYKx57EMUybvYbJfbArvZYH1A+/vrPk/oMHlRdm51SBWyv80CffGOvV/jDjyeudwABZODC/UXP0SAUQs8Hqwshi8vCydeFtOaxxloY5UWl1Y8Ea8nvXGZldmnciwPrak1Q1KHL7kwJXoAp+uJoGRMUy5EZVr7977qsZBx/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06in32XoVAzynwMUVtypK39CA81SutdZUxm90UA3lbA=;
 b=e/w6gZK/+5khlbqTGx+cHyanT/0Wz6+ITyBcHsV6KLNXlpnPcHzQ5ooy3p/MKRapCUxS34hn/Xkm1UiNIQb4bOmbTfg6g+NFdOsHhHXedhdPa+juanuUNgp0RDkBgQ5w4H9oJ/BX3HtngUfiPQ+WGUHLgn3pIT4CHFw3lAlTcK0aHsn8lA4nbHd7eaJHlu5v/qoiVKHbe0poaIYhfi+aY7B0/9x2n+TMxYuqGvdj198dPvBbSvUl8ddwoWVF2sj/KjOgG0VJt4E2fV3P6qP0IBKjbj2GPreqBMzkNhyHkY0Wym240vdMHteehOkgktGIAY/awg+IDeqWRA5L9K3THw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06in32XoVAzynwMUVtypK39CA81SutdZUxm90UA3lbA=;
 b=fixnuxrjfirx+MDkZO15slZjP3fSaqRYaNiFY5npaiBs+U+UvNOGbKuUohnGMmj3hapsKqUKwuOKv5Q9RYPlXqkngRicSoLqdw7p1K7y+WgAfQPTPDklyq//AWsFYF9+AGrCLj11tupi3gx1V/6p09qVVqrQAQFU3DMWUCHfPnk=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN6PR10MB7491.namprd10.prod.outlook.com (2603:10b6:208:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38; Tue, 13 Feb
 2024 20:40:24 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 20:40:24 +0000
Date: Tue, 13 Feb 2024 15:40:22 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213204022.civ75deudnajxkdp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver>
 <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
 <20240213192744.5fqwrlqz5bbvqtf5@revolver>
 <CAJuCfpEvdK-jOS9a7yv1_KnFeyu8665gFtk871ac-y+3BiMbVw@mail.gmail.com>
 <CA+EESO6TowKNh10+tzwawBemykVcVDP+_ep1fg-_RiqBzfR7ew@mail.gmail.com>
 <20240213195125.yhg5ti6qrchpela6@revolver>
 <CA+EESO5F7RB-_AwgxPV=9tCKx=E59sbaxvtc4q3u4sCL6PpcTg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO5F7RB-_AwgxPV=9tCKx=E59sbaxvtc4q3u4sCL6PpcTg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0057.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN6PR10MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: be5573b4-3c17-4f18-3cff-08dc2cd40154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K4oRntG3rbYTwdKRnbDGbTWZ6b5u/rqTvfPTNfaIwgf5gwsqoKLQG7mg5cxe7BRS+TpOVxJu4Xcr7AIvbtjTdRgBa4lOoSRoaDsZlLU0AIePvCu4yRiUEwjt7Q0L0VipnmR3vlvcb+CRxX2eAvcymlhvUXllPCU9cHwd3ClBJ8yMaJIcKbe4wfo5A51oomQZeYryga/NygRWLs4WkyILwp42GD6jHLXV8cMjj6sqI6CPFqkcMHx4N6NcBzRvgBJhQA4vik9zdchUug0vdzEdUmUglVfj2bmODBBhDTS7w7IepW2CoaNNYBB4LnI9GXjszuDQGMOXIlXq8/Fz8QJIDJUH/Rb9s3g2vZLORT5FCe92PQgn8cXdmBVCT0FmxVeoimJKEBW2dZseT9nnJPe0HJIQJifTbQ+lhyiBgZshW23q+0Ll+t+hScpqkd/pfJAeD+iaEnGJcEdmZHscMhIszgV/e7btw70T3fJVjgdqIQRQt2Tg76w6lDuH7YyrvDdLpGgvZv2ISHDbhGC25DY5ykP0EGME4IzrWiZmLQ9rbYon5jGt3/Hb8ZH43xcQm5bA
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(4744005)(7416002)(33716001)(478600001)(8936002)(66946007)(66476007)(41300700001)(6486002)(4326008)(6512007)(6916009)(26005)(6506007)(66556008)(5660300002)(8676002)(9686003)(1076003)(316002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6Q1mvsKn9LICl0ECbQiWHKwkAangckunXl5zjJ/H8hxP2USzBxxC5pcngI4D?=
 =?us-ascii?Q?SjyVm3OeBX8hrzwsYWEWeQxHJr/ZaslqvrAQk/HCJ9s6lQ7iVuUfjMeFQMNc?=
 =?us-ascii?Q?5gOOwxrHYlOv8791V5zYzV49gc/EWNfVImzWiwHZCMk8FsmNtm2glxY08+pA?=
 =?us-ascii?Q?oqKctP5fLurP+WG3M8gPI4TCAFhnJACB2FQnLdDIjp6oZocVCKI+sLsy7jJ8?=
 =?us-ascii?Q?vUrYCgAHzbGxxKmKjNOx6/Qih0oLtJoNNhYDwHEjhLVoh2SXIKZphFrZ8F9Z?=
 =?us-ascii?Q?9hwzGz667R1lbJval/+lxxsaavkoRyhT2B6wiWqnfm0aXmWMz+hwvcE8hpbE?=
 =?us-ascii?Q?kYpkmdzmpd29mRrxvrmJWnzhrj7D7HGST9og3SydjtpTLKbeN8fhbzs8EQQE?=
 =?us-ascii?Q?Up3+IQi1N9ujoyS26qunjySJyT6q70XqXmZx/+D09luW06Fn1ell2B8HvRpW?=
 =?us-ascii?Q?jTcNBLgJL8050rMywZnjcqFdle2fQq0LtzjmS2SrBdEETJU8nJ1eShiEyCB5?=
 =?us-ascii?Q?FeSzpv1YYuesMhtHLxsWBdH2vbVb1WM0jjsnVNBlq2uvXwOZxcT8ZVdvZ1Eq?=
 =?us-ascii?Q?9TPIhDnf1+BgNTFoO4WR3l1lmUL1lYLPd/Gl1sGdO13IozQ+a1cEXcYWSmX0?=
 =?us-ascii?Q?Uz0nqqNFRGzG7z+17tuxt3yXqGBs/WZjjg00RWxe8mk0R7TAQ0QwMDobcpda?=
 =?us-ascii?Q?KcVtP0G4isx8wbYs3AX1jY2RNC2wwJwGCMlyUs0nQX796Dh4zTr6juN4Y4Q9?=
 =?us-ascii?Q?TNEYabbOm+tQFvNevi0IznKoFZ3b+zjKEUjTwDHX3Vj2yN0ut6DL+ehbeRc7?=
 =?us-ascii?Q?HfA9BjnY8bY8i6SrZtLxrqTq+PqlBj8wD6lM8/NjgQ30Aq0iwv4q0XuYEIeF?=
 =?us-ascii?Q?dvVBFGlA0YqUKnUcexivdmJ/FJMItcB9Iqqx384IDvV+fVm7mN9SRkSgGw0k?=
 =?us-ascii?Q?8RvQi4+g/sR/J0QM4YiS4IqbFpTCYlFs7z9rH2NWcn0vlRMDdWL1PwsgjiRW?=
 =?us-ascii?Q?HRQsEqV5usjAJop4Nd6zeXYIkXuHeLQ8RNqPSrr5fAsYozlFZhHC/6IWtG36?=
 =?us-ascii?Q?eed8MryjghC2F817F3810OSyBt8lkjD9flxXGLDHWaMKxiPhcZx7/FJc8HoY?=
 =?us-ascii?Q?ZtDbIeundi7PJmlLkF7e9hFFWPStBoNU3/yPZ2AypEAIpbs8bBHq2LMmYVvK?=
 =?us-ascii?Q?JB3VT8cOh78wjB4Oh4AXc15s69GOfkD9SZx+7DgEiOpDPqMLKqTdvvvQt4jd?=
 =?us-ascii?Q?lY9IBSYT0Y/WSi97eUklQ0u0KkZgf4omtiL3S2GtRVPg8q+nL2mhrGIOkFs3?=
 =?us-ascii?Q?CxZH0PZmXq9eR4EWLjuIX1L8GzdWWSQz1Q5C+D5H8EeoUYwUX9e8nRasrKd4?=
 =?us-ascii?Q?TDdR6i9ncK7fQeYnYKu3qB5rl/YftwTayVAoTISpE5RKUDe0cOn6mAc+BaQh?=
 =?us-ascii?Q?dXDqb28eCGZ4A6IyuN4Z5TaSmZy9oxHFP09+KkioGGgUraNFwfHKd9OGV3pn?=
 =?us-ascii?Q?+BY3jgLyR/17gNUDKlOsw7LweqsgvSPBxuU/BatP3CwspCLoHmRUoX4B5DDN?=
 =?us-ascii?Q?aDW5KwvcaFXmn7zNxfQmWw8EAbhY6Os7tKPtu7V5sKT6KKv43zJKzXC6lgmn?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7CvJG7reg8gD2uG0evLbQGL3DFdUYkAQq4QDk3AwcpXO0p9i4WiQncaP2qBzvlH5J5zdGEkyPt1QDM+rJd/M7Wtg7Gt0JmRPqt2fvuITTvudA8OXUlHRSlj7Rndnosl3Tvv6Wt3QzM2tsEzQMQ2jJ1k8RKkO1L57+9g5JwXQFlXAl8+nuEGqJHdzVrrxC87AIk4kJRgkxQ64foy9G9gmiB3IIHzCiH0CPPWy0vmpql34d4ChYIYqNXlcHe6rnpHclLNIHiaN5NP/F0XV1sJEpuOT6BQBgHAkL8qtLS4nQ6eB/HEvFDwn7WsCVpyqn9C+p2kK3VMxetkgVTSxArraa+UN10yT0AEb1G9oE7ao45MHuOg+x4UFojS8JFIYfv0nIR8ALx8QO2aF/XtlmXNdJRGXdE/7GgpHllnPlrVpXaiKAGYlNNBjYWDpb3vme3be4Y0pqLZcnwwV3RSpVqAI4afVOOFml9gbGQKnI8W++HYCjOkIR43ZS/C6MkLB6N6civ0kXSe0aX5ORcvYEUiVq/XRZ/ZYfNRno5Dae8ibVayKpKWkrULREo/R3ZdgOenu7hOAZS3lPqUN7A7cSSFgMwiygnbhm5Ff8u7euS0jRqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5573b4-3c17-4f18-3cff-08dc2cd40154
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 20:40:24.8079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFYGcS0DaYGm9eoO252tNRFnjYH4sq77AwmPYDVqtNKcss5mJmq43a9GdcjWtb6FuTdBejM75USbSdskVi+uwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=825 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130164
X-Proofpoint-ORIG-GUID: i4v-bZrey174Yt7dSv4nPga-CjVfMrdI
X-Proofpoint-GUID: i4v-bZrey174Yt7dSv4nPga-CjVfMrdI

* Lokesh Gidra <lokeshgidra@google.com> [240213 14:55]:
...

> 
> Regarding int vs long for 'err' type, I'm assuming you are ok with my
> explanation and I should keep long?

For such things, I check for consensus in existing code:
mm/mmap.c - int is used when not returning an address or struct
fs/userfaultfd.c - decoded to int before returning

I'd use int to keep consistent with fs/userfaultfd.c

Thanks,
Liam

