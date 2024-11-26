Return-Path: <linux-fsdevel+bounces-35880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCC09D93D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 10:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC002866C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E2D1B3F3D;
	Tue, 26 Nov 2024 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aqA2Yv4/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FGRJ+c0e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE2318F2DA;
	Tue, 26 Nov 2024 09:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612156; cv=fail; b=QvE4954T/ljJiBJeKrSfp27bn9QfvBZdP+RsZK67qH6cQvuAQ8EqaV8av7Gfzj5ksvejOlS4xSAueijpNcOX1Y1WgGqPjYOgYuQNr0JvwiOs7l1wuwI7Qd8tLl9SicLuDi4CFGYjYhPbqg2MozrVaOcMUlqb4UHP5a8Vc2eJjNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612156; c=relaxed/simple;
	bh=D/D7ScXh0sQBxkH4wJHVxNW3KpCv/XKfDsmUV/ngkZs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bvLx+cH0T+OOjGY6UtniEddhnCWqWJPhduddOGiTccd6Bw3Vg/z/9ckY2OGr22ZGOH2AjuonEVtKxCRosB2H4pWQEEnjjteJq6kh45Pw0iuJ5onXoAP7cVeZnfFgRlEkk8IsaVshODGthi4adC7vzi+cqUwytHGj0rjYzlSkM44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aqA2Yv4/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FGRJ+c0e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ1NH4K014860;
	Tue, 26 Nov 2024 09:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=j3iEcqvknmPGBqGR
	NefMlZLXtrX0NLJcXSqteE1/q+g=; b=aqA2Yv4/7zIdEtrhs3BAhfh2VNHgCa1e
	6OeaMu+51TtOFMhe/+fqzK1+Qq7U7ByGZH4LtBL8+uofN6Vk3XyAJCKlynaCFKmv
	zIx+XEtzwcpN1OnV817lYaIHBZ4HbPKvC547S+ftrZ4bkBng22TeL3cqbL794RRY
	y90JYWL4IOxmvjTEzqq0ofzl+Rw3bltqLU+FtYSTTtMYLFTIGY2+VM1oUzL79mxd
	4UTCTlMrucbBh2jWrgMVar5TeaPG9xTvJbWbTcLX0nKWIITQKjCedn+WiI4CEXdR
	gtTsqPcwINkhRIWb9qh8ZuPfbiJUCSmPswLc8NyKtcUhA8uyTcLoAA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 433838n17d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:08:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ8lttY023561;
	Tue, 26 Nov 2024 09:08:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335g8pj9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 09:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjHHWtg9B7ZtED0+7RLBzc8Nq5y4IRTrx+xts1NVLBnYfFBytY5PMGLT+A+zxIQu68g0adtRF90zg6OQ++MJy+iBPAwqBfz1T6oi6HyT2FQQCQmGicDPQeyd9sNmeEraKKo3qMyL3k0k6177CRFYnJoImzDGSrFr47R2sNfgratW76FoJ6c+iTZrvqqFhtEC6Y8kKQhMk2d6rQj+Qbfty5SSp5SODNsFAkIOVwuRGR5GB+7JdkBOnhXYNdgAkeuNmrjEcNdsuVeMZgHREW/uhul5fstUKTakJKU7jkVFO1BqFJPs9LketfnLe/dtpunXXxaTGTyXfzVWTeI3PnWuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j3iEcqvknmPGBqGRNefMlZLXtrX0NLJcXSqteE1/q+g=;
 b=Vh94iLvZiBXHjMc04R+eeGR7g0AZh2fRnjXzuKCPGMjLMehJoba/+T8WLVjGYrNcxSO53DarQv+SwraE0RZkTZjLXzXdA8WNk+kFwvIhVBSQSxTS9HGvDEovDdOsjXm2RM9IA4p6x+yTb3e80YpEwAlDVF3C0a0G787Awqrz0z5oR7cXd9yC6bbWmgIY7EF5X8uikEADeuVnTRJVdiPE+LIJ4fyUCXgNfm4oc1onKZlWwkHTTRXEMr+GacljCPPhezPrJblqksWL9Gmt9panBCll+1xZJVJQuTbQYPkS9qALKzTy1YSIPh7EbAtig8sPdrTS8GcHrGho+1YYg0y8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3iEcqvknmPGBqGRNefMlZLXtrX0NLJcXSqteE1/q+g=;
 b=FGRJ+c0ehrthPKuBSgX9wP12BQSL2tq03X0ZtU+194XLK1Mq3gv6Ru0Zvt6MopTKer73Ew7V7Fssv93DaLwnMN8iy3+5pmwMgU3ja3BCmG1/nYRnLdB3Xw56G6ppsnl+/Uf3DRZjTLHLV4qwlsEbTn7vGvUeZq9B3AJUm7bwfSE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5086.namprd10.prod.outlook.com (2603:10b6:5:3a6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Tue, 26 Nov
 2024 09:08:52 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 09:08:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, dalias@libc.org,
        brauner@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/2] man2: Document RWF_NOAPPEND
Date: Tue, 26 Nov 2024 09:08:45 +0000
Message-Id: <20241126090847.297371-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0097.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: dba0dd1e-9676-4c42-7189-08dd0df9f2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bPscKB9WJEMvVFqG2N9KkKjhGPMQW1cjF5mlO3m0YW3css/ePzrRMh+kVe5e?=
 =?us-ascii?Q?Db4qd7KOaa6uC8VCHg/HfQ2IoLqjYiNYkKEwzX45ZYoKrRZtc9BDOObSYhlZ?=
 =?us-ascii?Q?l+5PBxkHvOr8lMB2SJUHKhNrya888e76Yn0xe6vyE27jXTAGBa8FjaYoxhw+?=
 =?us-ascii?Q?4XisaD8kUDTauoxbg/txagpHD0u6sU0RF1TUy12BLao91m3r5Kn7Jfr8AnaV?=
 =?us-ascii?Q?pBKWAkdCP5iehEq1YmmWyE7unBU3CzVvHVWmynzYyCIhLCPEDUVtxZU/1Sb3?=
 =?us-ascii?Q?fnrxq5JmpBaKDy7wpPpzr7iVpFdSZq0SigK6bIAXR1O+wlIfIp+UZvRZ+PhO?=
 =?us-ascii?Q?QfBG8GquGSaZ7PZBukPojoeaBFJ6aeMUL5PoO2TqKKtWPTZ2FDb0g6HmWpak?=
 =?us-ascii?Q?cYlE2q/dC0OpW/k87MDKdcxJbNBOAQ8ju+kugPEdkOM3K7TYZc6j3rXHRSUa?=
 =?us-ascii?Q?0dVdd0zgXPD/cEMpN8JdBv8OfAc1WiaDps+Wno1cq0okAgLXx7VqVUXoNlFy?=
 =?us-ascii?Q?Zl33LiXy9BWSojgW5XnxKuDUCEBu7d66OTvLgJtFwqkJqLlFy19xTsHpoOhn?=
 =?us-ascii?Q?e0nvXZ1TVYY8/K7Bomld55b4yn5n59fZmPWyWdQL/8sBdDG6eduByzh2V8z2?=
 =?us-ascii?Q?r23JYX9lsBJ53lrLcxjVX8MTaVl3jnK5MT52vitLOT4P5tYpr49HyBqcS+mn?=
 =?us-ascii?Q?Qj2YWc6sdN+/4+DTnP4Ruzvj0yJzMa5+pp2x1/MaZmw1OuQu8ZOtUjqUlI/k?=
 =?us-ascii?Q?VDrxT3puj3I5Cck0bG0AfnqFG1K0ivKZa7jpjUPnuJb0ocRJsBSzS2GPF+wS?=
 =?us-ascii?Q?GjTTOkpuki5JboJgYgXopNI6p8j5rbz6RQffSaO+Knh57Y76e6ECtgLBVl0X?=
 =?us-ascii?Q?H94gx5MwqkEXXdGUW3w80tzSN0dgmqqVVCv6rIcy5TP4uHvoRQYbxUIlg9MV?=
 =?us-ascii?Q?XkEvEI+r0/Mw9v/Q9wIwnuvEx304F8+5094bzWIiTznRuoa3Fk+OOVMkh513?=
 =?us-ascii?Q?9iLHzNa6eLKRsjNB/rY6S90US3P1Unk97Xtu0f1fGhkeK1/UhTW4ZYj4Hxm2?=
 =?us-ascii?Q?ziFZ5KhmDRXa6r7utHR3uBSIhXCQkdZMqxomTqbrl9wroMtYJorI50OdN3pk?=
 =?us-ascii?Q?7gEgWcs73KrZmwAfMC7qsJxlqqDFrcpoKOf9ZLH2YVXx7FcSCVCwaKWrcYXb?=
 =?us-ascii?Q?cM0DsVQqWdZ32cFU9JZpFq/AFPfzQcqyv4feFxY9NcfAmxU2LLhp7Z99bgZx?=
 =?us-ascii?Q?mtuu/oT8kKG8DFagy3//EFEKnxwmk9FXcYafSQV/kxcYtpZR5opfx7ftIxTR?=
 =?us-ascii?Q?zyIFl1Euq3JcEFpYYT2naicThi+0Xx5s6dKZBO3BW+l/Pw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ytHbxHXiPpZEGXUzTX+zeM3JXgdyfL2ksTHsXniGrvRn6tXOWxlKXJoVuj5y?=
 =?us-ascii?Q?938OVQIkIrBE/5Xoi4aZ1dwxr1Cwx+wM6TLQy71hJG27qwI1rE3VCdv0LdzQ?=
 =?us-ascii?Q?r5SgwaOcMXgV2fg3Jn82+zXKPQapw/w7sxuUropRH9MR5gEmjai8saF8emjB?=
 =?us-ascii?Q?0VqXSnU6sKpXQ8DfiN6oldrTcZN/Jr1z7RKuKehQt+dzodm0w4hbZfhtC++f?=
 =?us-ascii?Q?mrhswE/XYdN0ThDt7p1WF8WwUGsX+7/48KclheMHbBLetndjgqqqzE+rLu/r?=
 =?us-ascii?Q?3kyYR6MLrcbAO3jl/ntoUxIW1lbFa9U1sYV7Qsgf0+dGhJzAYA2fbAP4TQFA?=
 =?us-ascii?Q?9sOpKb+3+bTXxyFu/OJG693tpRToSrASe8ZEI9pB6gxRudJGd+63EWrYdkoN?=
 =?us-ascii?Q?UWLOB9x3dqnHLwQPafJMDTfcm4C+WdkCSw8tbYdbdchRzwTBW+W42nxfWECG?=
 =?us-ascii?Q?bUOCj2eLB5FGeL5uArLz1glINHwQyp/eNP0CKZJ19GUfPJ9dGs3T8U7UsuWd?=
 =?us-ascii?Q?r2GQhAPqeHZYnLBDAgOe9xNlNA5xIw880+8eMKawrhzv8IZt6ZPV29SJYlMO?=
 =?us-ascii?Q?mbyT0UEpvFOerBf2Jo7rD3/9b0+8EOgJFwN1T6qjmCuFblCndonsao+3oJlN?=
 =?us-ascii?Q?KElb94f4W56B5YuExI3boq/W8kYYHrzqLzqDsjE1uMbH1M8YBHreYqv/VbbV?=
 =?us-ascii?Q?h38Mf1ZPkwzU0TBdXrFpdcmecEZ/ktWkTqmvQGFqZTqGUb9acNzQB4PuRa4Y?=
 =?us-ascii?Q?2uZataNo6tiI1uXEeGx/RM6zRUZZUExZQkJaBwtzbX8qvpP1zOIF4miWMrmB?=
 =?us-ascii?Q?cLUk1cuiY3MB+NohwAnbW8SOyQflGpld3h74kH6gqmxKk9yFYvvSkWQ0ZGQV?=
 =?us-ascii?Q?NdGXOcNPmilsqiphw6V6IAETJTqiYXmJMDJSKEEYlACqkrk3tBq/vL43ZUHk?=
 =?us-ascii?Q?4wFnRCXbG1cYr5iTMxl6Ueb3e9fB4m36oIRV9Ifvk6aZDRlp4F8THFVejcni?=
 =?us-ascii?Q?ZUv73xc8fbAW+MKp/5qIRkqcm8GivAkOMm69Mk39AiEKoRRK39YXnAsR+2U4?=
 =?us-ascii?Q?8q23fZGvRu2ElTYJnSXexV48dj7LXC979gWiPEm5lmeKxxzhUouPeVT/tZaC?=
 =?us-ascii?Q?XVbgcJzlXXFdE8IdbBxW/SRwQcZ6YowPXHncP0e4JY8jHYV99YCItRpg71lS?=
 =?us-ascii?Q?BrZXAEKpDh+w4Nvltlyv+7wtZ5Ngub4KMpuQmO0WRH+CAC4x6vZughLreLF8?=
 =?us-ascii?Q?j11Sx40aFCVtbsS74sGJy0PDhRYAiOnsZgZt+Fq1Vlx8iBRs3y7D4HH8ef2F?=
 =?us-ascii?Q?Qo5O4ctV2Drypq5s2tIkprg4xFwOKRYQVwx7kdmU7AiNwGwp/4Y5MtstTY3b?=
 =?us-ascii?Q?+VXzbiQf1BXBsSj5Ayp5+QC8Zi4DVKQVyVfVb/GnyRYs3X2YMfXzQWDM4oEb?=
 =?us-ascii?Q?tTEUObTzP64Cs2wYxLRU1dBsqBmBAakAWoObcL2WAaIPnGAgZ/QzTgzg35fA?=
 =?us-ascii?Q?T3sayhnsMjXfb8Qy3iBqirYBYydzTyWQbrzouNO8FafGm+vFnc5Xw0aqKuoR?=
 =?us-ascii?Q?tEH5aSI+F4YoAIfp5pDUyh6d65Zs3ZXc2suxA7ByQLuVgoEfVlYcFJMEBMaf?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z77eNU/Ngs18i/JdK75vzhFh7k0xLRbf3R2HR5WigMaHh0NsuCyLKiVkBm3wTaXbWqRueo3GSpjmshtgXZxoVNShjy+ph1CgvMoTSEsaGFA1sK+Q9n3iKKXh1xPoX1y3ik0sq9mDXGoP40nNyfPGann8qfLikjTzl4n19c0XNQCLuJ6HAMUYgm4V9+AXjNMtqgbzLphzMiyJB3vlrG5ZQvhsY58ERNmCf/MWiJbA9UkWSfdJGZj6Z9Fiev2X/qAD4ppmsroALNtVOQ4ZmoHYE+NWk623jmVK5KFG53cYtFjgs4YduAhGNGTPbcVZbMteP/hHokWbNCPBtu7tfdCpIYJW9qvJVrjPoGWS5zcMM9m9o7JB2uVWzskUI4Er3RZRnebMu2ipvxqj9yC7c/LTOAyRgM+tn/gGRrZ/pdcmSzQ5dFCl/t4dtMd27NK1NtbQiMSZHqfLX70HXhZQDVF+GeWkFHrEyK2PJlqlf6i0NtZ+fH5gxggronzyh5uNodR4RCo+pzW1Qf+EfLKpfNZWoNAIOM6kS0wGV/HNTzA2CUHj4/CYfrn8CobbIsCrl4CAzw6rJgC26xsn5nTrMPvvZ7qLHYesliIjSYLoNrSbuoc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba0dd1e-9676-4c42-7189-08dd0df9f2bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 09:08:52.8160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zY5QHmRNhG7pUvExu4edlVl3Z1oazOnJpI6VQrAzsA5jTcuPqUf5nurleVUKHvRVBAVxMH+yrPQDpW3ldfyZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_07,2024-11-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=840 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411260071
X-Proofpoint-ORIG-GUID: 3G2CEi82pF5rOVl_ZX5Qk8ZCPxADa5pD
X-Proofpoint-GUID: 3G2CEi82pF5rOVl_ZX5Qk8ZCPxADa5pD

This provides an update for Linux pwritev2 flag RWF_NOAPPEND.

John Garry (2):
  readv.2: Document RWF_NOAPPEND flag
  io_submit.2: Document RWF_NOAPPEND flag

 man/man2/io_submit.2 | 10 ++++++++++
 man/man2/readv.2     | 20 ++++++++++++++++++++
 2 files changed, 30 insertions(+)

-- 
2.31.1


