Return-Path: <linux-fsdevel+bounces-48195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FB2AABE6C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42B87AEB0E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14094279905;
	Tue,  6 May 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N0wprsso";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OVf+IjR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EAA26D4F2;
	Tue,  6 May 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522342; cv=fail; b=sbb/TdvqUBw2i4RinPnc2G1xZY8DR+HWhF/AABguKsi2+JjAoyVw/zwTN9T6w32ZRrzdMArCk/rAy9CFTjNSzgAFGVWgUJdoqTyiWZ6fJaVCIIGnhQzr+Cm7DUU9ZzGQislGrysr2NCSiT1i8RnrXYRiiXoN40CSTUNzoCHxBTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522342; c=relaxed/simple;
	bh=ojbL9ETQY9oFRhSdUJ0ncgTmZcoEGxx/N41SjSyeLlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PxX0JOPjn+/43JYQBR8nLs2Vvb+kqMAB8Pr3Cm6ScDKZRMpz5cn4VWBJukWGn1yI3KPpdJthhImz6TGiUk9ScbI6LGpxzpsFSNS+p647+/eawsceExSIh5VpkzCZvIWD7Ga7nfcCF1mKWvFG1WeRIikk0BlYqc0g3c0TYg51L98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N0wprsso; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OVf+IjR7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54692LuI011503;
	Tue, 6 May 2025 09:05:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=; b=
	N0wprsso/etwUCHJ17cw0ZqNuHRhUJZMptt9vmY5923eIgq2Sq0BG+7wfx3pdCjZ
	g+lpRlONO6oLqckDsKm0AZ9jKjhtDJ6yGZ5dTgo8Vc5yUb5B4UYzYn6PJTIX7u+i
	Uezy1z5KyTqdvpytwyPjhBIN74XHfPWPRwNy6prEBAwAWZiVEHqOnGyBbPiMi6NH
	oJmULMbJR+ZLMh0sTdQYfIIiJ53Kmj3rE/bTvtCdOScVELt/6SmvOhaZOBxQGZJM
	3/R8+PngFYQdwo+go4s7be3jZytEq7sq70r0Zsi+06D1EDKtVl11Ypa/pu6nWZxB
	90A0T3c3EBGbQk5X/yKNog==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ffefg06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54688qMG036019;
	Tue, 6 May 2025 09:05:25 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013078.outbound.protection.outlook.com [40.93.6.78])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k8rmye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IjkXyuz2jwB2WYQr/bLnt22Ibu91dAWxcB9nSokXrhmc0OYGP2tFJq3HcpidbD43Y6fQoCbvl0k1cO6f6QP2jNvLh++ZIdfJ1m1K6AfnsjRf7SmcP6sadXEtlFg/a15n4TMsGVHIgUQ4ZbcHixIUWN6dBzNQdkhaiKYaGmfrwKJQNKNJpeMqfhjwcCHYDzMo6JHuZUR7WH/Ve/4X/YA7etkx5QOSo4jA1A109SMD8unhPdh5NIaUzOE/nWwzm2WEWaFr1dyzEYpRvTQzF98B08ai8yUyzVj878HwqtrbR296KG7J6W7p4qqm2sl3WENQT4eeCx4E3D7dtIq9ZfXgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=b4vgOKrNpLN0tD7v7DKwD1karSX67SN8g2fWvdsIXnkcBgRcQEmYqWxN9MYZOjJx2Lu63FRY/D9ZUkWWrcnYKrWgrHhlLHwM/2itWrJXf2ZUeG4B6k+jMS0IpDDiJ6gnAumnlk27FMhCj5/GhVpZgP06+rZLh2xAku/o8IGkpjXYtdxiMX4HHEHTrHd9rut+pQ6XbsWaQkMVix/QPYi83JWIKvVYTZElfBQgRAHwqrZjllsR3dNjCtihOdzPtROXX5pB12liGfBe69vM/W0+05XWGRtStrEr56p5Kh4KH7qmhkDcD2eFzAWkQoZ4aMQ1tIuIThFNeyRZw4uEjvXLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=OVf+IjR79jTNp9qnEoS/DpyvzBl4qG7xJePgiLysPOJ9Hz+iaF3uZY1zwp+rabNyhw7qESGNF7S3vLMONvH7hAprd5wO/ZJ+iTavppXeZ0zMRGmyXgYOvgaOaq1V38IhQ1QjvNihAY0SMeuTTZzuFM/j5+Ty3g7auTBpFQ05nYo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Tue, 6 May
 2025 09:05:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:18 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 08/17] xfs: allow block allocator to take an alignment hint
Date: Tue,  6 May 2025 09:04:18 +0000
Message-Id: <20250506090427.2549456-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f5913d-1d24-4ff1-6e6a-08dd8c7d1f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?relSnXW2z5/6ieIfbnu1mygHd2Qat7e44E26lfFBJcPEXrZwmGnpItm8tkgc?=
 =?us-ascii?Q?ZOND/LrXsXGnt+18Geg5qlH+gZbLtE7QAdhDn1skAGWNmetq9cw1AbdvbzQF?=
 =?us-ascii?Q?Vx7NHiZo3Fqk0im6O0cZUZVd172Kq+xo86mD6BAfVETZyi667mN/CZ19rRQj?=
 =?us-ascii?Q?YGNPT7pBDubK82GfAJFdiKTBfNCs/Kv2zAp8+0dR8N5vtX7eNnC5nJ3AVxO7?=
 =?us-ascii?Q?/pPKApGxt02l8BG0P8qrzmHKNoXkJYdELofVYLcexRIGCDOeeCa2qcM1TOg1?=
 =?us-ascii?Q?Y63s8ZQeq7CF1U0ZH7/+XQ1NUsGLaQcRMOid5fZV7bIkOqCl4xBjRDnpD2MX?=
 =?us-ascii?Q?LIeX5IfyixzDqa7q0eqOHX/o3AdNpYfoM2FYjYLP3r+2dlBIEK8DDr088MQd?=
 =?us-ascii?Q?9nUUU1eHU7dlxxdfI+S1N/RXMCbfYzpNT2KZV8wTvs9qHud2pwlvPudt6tRr?=
 =?us-ascii?Q?Huh5+90qtxb74z7me+N9L/vf7pwNmtF5YzfLljvwMp7Um4LmlsxN0n/u5iHB?=
 =?us-ascii?Q?kOIMLeqUI5KBtsJ0jll1mXrga4IAzMfLHnlXh9KANMy/zCEWodVP6eFrkbbd?=
 =?us-ascii?Q?DqYcTMrkw4V7B+ipQHGBxmvN5NknJ9kboofFCQX3+KrSldjJCC/PGVb2WHXG?=
 =?us-ascii?Q?wk5qnpK+i47hkfAti5lb+h7wClhUj+DnkKn9wEtZgmUHl4dL4VqPgyuUuiDB?=
 =?us-ascii?Q?fq62k3jvDURfX/Y30erI06Nzb4jOuE4dMGBbxxIM7184RR1Swy0Z5tU8jhi6?=
 =?us-ascii?Q?uC5AnSmbAupR3TmVRqooUNFrIn2zpxVAi9pAaHF1JLcPZMRZ4e2WxLbo6i66?=
 =?us-ascii?Q?omN7MvlzK7P4t2Q+7pCCIx/sS5vYSSXA7TwwpSQjGFtdoqP61LGZ+KUGvJow?=
 =?us-ascii?Q?5r5rs1UQQSDteCqWWrZJRTbAm++Cq/CHi6LeLTh0LG7vaQ6ABoMWHc0+YFu0?=
 =?us-ascii?Q?kAoT64eOQNxHSpWyIudx4vHkGKlri3Jq2Z15YDzOBKaA0Pye/bo1MV4npKm3?=
 =?us-ascii?Q?K8fYdqHc2m8GnnWaPYYE7CQWSw4vPY5butrdPw4mO3bnJKFV1n4qJmjVAAe/?=
 =?us-ascii?Q?zcbLo38jPDJutXsAf+Gs6a+NKHR1w7C2ZkuRAmZ9q5UQQs3GjvpxqIwAMwpJ?=
 =?us-ascii?Q?ufLbMJ53IncdL3SAo7MjocOnDBpNIPQRwdirEJRPkkYzJi28NYFERi8iiF0i?=
 =?us-ascii?Q?zO86q+MOrUTmEjTE+bNnbsHhHmdfQWCyxkWwQGjgX9ULtKJIEyvboy/1I/WG?=
 =?us-ascii?Q?7Th2T2WLag5khPyHLksQGgCrZ+oTp5MRiQl0ERYebKEPTPO5Cj5aMBJk8G3U?=
 =?us-ascii?Q?5sZt5Nqa4ohsgyyF9yOqRPCWLdLlMiU/LK0oAcmm9T/BNPL5vZmuGG1p8hIF?=
 =?us-ascii?Q?zQT5MCdcYTh6rLq0ADCObzINxAw0OpAgJN+I/3RZpe6vo+ldzAKglqPer88U?=
 =?us-ascii?Q?aHT5gekDQAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+lZXU6+8eIQ7WX3nYT1PFTXTEQLcTNHaNo7dYn6j+HmLrmtI0fpkAR4QMJAe?=
 =?us-ascii?Q?09T3/HICJYghJYkyzlyD/MgLQHeuERSeD7etoYPjlZplNnJrQ8WFdwKsDAs8?=
 =?us-ascii?Q?KFpjBK1KqyTjNnN+/5C6eVac4lNH07a4jYgSdYrV6NHqxu0vleFIPNDNJGr7?=
 =?us-ascii?Q?+WAUt9OqezGG2YcuXz8RpBBYcg39agVguhLyWf2Zs3HpfWRfcgRDys5Pytne?=
 =?us-ascii?Q?5RK3mGAso0RJfHeM0oadKlhfrj/ekX8AYlZ+Vp6FfAlWtBxJnmkMMDJAsULl?=
 =?us-ascii?Q?c2b4RO9dEy+cReKcmn0XGkEtReTCMCXDJ2RGZWwHNP2bUCHDh9tYZ8Qui0q3?=
 =?us-ascii?Q?DYYZSB7fh7YNQZiOM+7o/FwtQ8D4UNxXMbqY20vgyOD+bqI93QFUQOiv4S5Q?=
 =?us-ascii?Q?x/fmHp8WXTcZDCjHmeHpz6oMghmBW+1uuYkw53bs7Cd7W+aJcfb8hdPgBaZi?=
 =?us-ascii?Q?aiq0W+s2QP64jtCZ7OIARmyjENWSrhGcQEF3X84tF2llsNBJS1lEVySLkrUp?=
 =?us-ascii?Q?bQiKXfEisjz0KefY/oQXVqlV+bwEW4gX4y39lJpCqFa2rv7C/QTWPuNgif4h?=
 =?us-ascii?Q?ImAo/Z7CIjoiZQe7F1v2dwo0SZWZjH7bs+5SakLOHFiq/OsMgfcRHkDDz2Fo?=
 =?us-ascii?Q?Fd/i0SxiiJhGyZR2QhrmoVOiVhusatrqcVqZLcKWg4BOQHHnF0RMxDu/YcKh?=
 =?us-ascii?Q?SsoVLIT42D51OJtam3ggk9sTzEsaVMD01+6wrS6mskhmh+Tqhycw5XL2eUK2?=
 =?us-ascii?Q?MzFltpydvO0VcZR8Ixd3YN8SfaaOD3fVEGOX/FOdE9FLHOZ43k7MpWCqibJu?=
 =?us-ascii?Q?EAGVY6LhcnxKUWbM7u9iDmn3yip80ke0JMFHNGzu2QY1DY4Dq4oB9JgvU9UN?=
 =?us-ascii?Q?SS6tQfbetC81OSTfKForaGexLWDAySlpR5QBDs9t3cySIY1TT3/4ZO42D+b5?=
 =?us-ascii?Q?CBt0IsaZn6ZXs4l8tCvhZBS4h8PAYDipH017Gix+Yulz4SZUt/bHekeFDhHf?=
 =?us-ascii?Q?SiA0meX6/9ZTD9vzNwgZ/mAfEo3jZclQEoQR9DmOyaTKLk7RopEi07XGStO4?=
 =?us-ascii?Q?XnNlc8sTAhV70MbyxDYAKjFeGerWO4qdcpgqkwW9Zt7Nsxzo/tZ5GPyWRiBw?=
 =?us-ascii?Q?gKSGeB0dl4v4xNtC+vwCrYKkHp/eH/X89inBiK52Fe3BR5bYNMF3pmI5SPE0?=
 =?us-ascii?Q?QkGzb91QWRBFtcqCPGQFRXYVQ+79I73l5YTwnrv1RY+nmdAEJOYlTo/3NDF6?=
 =?us-ascii?Q?tCh3YHcG7UGJRy1vZfT/WEXCOs3J1+/sHZHWM0r0CmVF/wavVjrrMmVJr327?=
 =?us-ascii?Q?woc8CpXfB+4DM5fxRQuaeCy/WypV5oRketOSGe3bG4zeLLAKsZKTmRKwMOdr?=
 =?us-ascii?Q?llo9Dfh95ywcALWLZvnateeFedZSv74UnFQYoT064abTcOhXu4t+xjywd7Yt?=
 =?us-ascii?Q?ZXiDpsF6GlilrqBgl3zTkLpZ442ehs1ZMBBpPDzABcH2jjfDbSSSKLC8nGkE?=
 =?us-ascii?Q?4Kp3d9hlzoU3/+SAEOZjAhZPM3zfC/BktzM2qzoGX4DAZiBEBhf9yWT+3sEi?=
 =?us-ascii?Q?FmNSPcBJJtdshxZNOxbbOn+1qF3MZhDdfUBcjrIp4gtlPwNrwKADkl1DF01r?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GJouT/8FCmLMzV9H6QXyHG7sDvX1AtS7mk0zOlg4dzxf1Y4yCxcH3N6vEHPOL4tVc65V0t5DxhnCVNDanFcUXNLG/H3ouOV7GNBE8xqTxjTbT/F1u/mZwensi1hk7Prut59tt5uDRYLhw2YCPkycMRgpSJD1HRASRwcNDBS4uSscBftQyzV2tF1nyMkh2yPS4HcyCiI6HSWjjPXQFmsAvDSKHBtXcV9kynTeHjtJ336srtoPR+1iGtp9m0GRKvQYcEYcE2GXLd63TF8rTwoTQ3+x+dTjaWhsOc8URm7DBxbdCtrJFqbGKjkknEnQtLQNVWNy+xVfV7IYclKDkyKnOyZbtaHHCuEoLBDW7WR/rrVwz1erx537FGJ0QvC41uVKoTBJkG6GnI2I/BJinv/HPtZHVpJcU6PIpkUuemwNHRMv+nXEwHsoZQxU0eWefr1CCDs68HDcIS5AFDDM30doK9d4VIrK459560sIGt/QF2NidDc+GPohE0TwJjDM6JU+uZigtgCyaxj+YBjL2RzoVawQSWGOBk+Al2rUwbC17iI8SJta9RkDb2q515gbLqUEMMSwY62dcu+0vW2cd5Ed4XwavOVNvQLDktWdMjxWkN0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f5913d-1d24-4ff1-6e6a-08dd8c7d1f6f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:18.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ustPeh/kM/P2Tk54gHFjA/yn9oHVGeDpy3MfO1m9YaSfG+fV9/qBjqKQ0jdrSk8HmK9aBsMzET4q/X+F6EBnhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6708
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505060086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NiBTYWx0ZWRfX9qI309MB8R8F PdxqPmRCpfuZ4kuFZ3zK6FUs78W2sPP7DZBKCYtzppCaaD/bIsjqFACLjUXRO47qs0+GW8Hxdjv m+7wmaEeg6h6bqhBGATO7PNBe3nsoGNPYPmFSHpIxxUgLjgFcHXJFq/ICjStQt0unaYjNmrtWuN
 18ReFBUywASxHdbmtANvp3MIBHFXSwmodPvkowc/H7gR8WUAbN/zaRiYs6/+jCkDRrBwB/pmLyN UPNDNbSQo80VVnyiVaLqc0vZU1Xj6tzczGDRD8RnmjV1Ufd0Bh51sAcx3WUTIEQyAEbpdOYbJIW jI9RGqDg8i1+KCZlll0+pcoI3RikfdW6Qlf0Du9Ur78YJsfhyG3ie6u13HQVYU++msbxfqltRCj
 OOmhplCiRCxdY6pchWD1mnr/PCu6aDec5K7sSWOruVCyI4CN3LaTX3erYqVbELi7r5gtgOJf
X-Authority-Analysis: v=2.4 cv=V+t90fni c=1 sm=1 tr=0 ts=6819d0d5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=BdfLSKS78uDQwj0SyGAA:9
X-Proofpoint-ORIG-GUID: U1nInS_ut_OdRHqqpjSOZP9_A-g9sk0_
X-Proofpoint-GUID: U1nInS_ut_OdRHqqpjSOZP9_A-g9sk0_

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
-- 
2.31.1


