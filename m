Return-Path: <linux-fsdevel+bounces-4609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D42801490
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 21:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42D61C20756
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142057861
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MfuPMEud";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j+m/pXEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32EAD;
	Fri,  1 Dec 2023 11:07:03 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1IsGdH021549;
	Fri, 1 Dec 2023 19:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Nc4Ofrzvyxe2YIpJQMB93EvDF5c+fNFeVsHKr+ypkko=;
 b=MfuPMEud7XLKQulSEtHFOu0ov5uyWRZXPEiUeyKbtygTIozlwBGuKlR0P5ZFhjY/kSSw
 rmuUg7mfu0JlieussYQnJuwSDrdYWF/cbsW/Q7U6mb2yxg9/6ZRc8DIqUtNpjqpCdckl
 uNQRuqXFCMxA15Nj7RdrNJNYpLKxdH9YWPFyd5Km/um6UTucCrb9RIfVAB+dbv57dCwN
 Jc8Mlsxd8cA/Iti+TbQw7DmdQJuYSUwRJWtreItzXftmqXpki+EcbevRm+EaURYOGCkt
 1FbRJ3DYjx8Wohssq2BczIOBDLzp0JOKwChOTCLcz9pccWVhj+c3H8eUJK+FWw+fToFj pA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uqn6380tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 19:06:38 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1J0Zc7012736;
	Fri, 1 Dec 2023 19:06:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cctyj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Dec 2023 19:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMxIS2yEoeFlDgZinpvj1zLuaGFQEsrdfAVN4C+QXvCKN2mPnG0Dm/t4t85So5FKd+MklGJVkzpYGNTeW0+uIWRCUvzQwEkzPVGJ3wvl5kq8aEXWXLvRwRHYjOY/zXAqNAiCQ+v+jQr7ctoExnMttt1on2wIUIKt0JVy7JFft0lQKkuzj35o+Dfa/gZ/nvQm+juI63vO+GRVMg4Y0Rb9g0t8mbs4pw4E4nvNPK0E3nDVIPcjzf3kfZvaDOiv2iK6SmTNgvv1+fm7EZcUbRSmnnX5NwfVpNO52OvtQr8jMQaN1eRRMXZKqLIrhD34y46Ll4tWS6Bw8uhojzTgRcLqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc4Ofrzvyxe2YIpJQMB93EvDF5c+fNFeVsHKr+ypkko=;
 b=lCF9sbp1LpDPVui/d1XFZ9hqmDGOdtfFAIEFiG9E8dOUCKVUTgY9kU9UmfPnVxy+Ww6Q5mQXv2AD44GXuxNGADZVk1N/tXZ082vmiMIj8/N5KdlLxLGRTM1SJ8dhlX5fgglJE93j4l6YN67AlUgXYdo/fhjgSweAhIixEoTYCuOA9qA5sAUEiWrmyk6mqJug2M8v7h0/FjKKh1pNB7v5FHHP9B7I8MhBjic+fYtHlxkhPYpXWUXBonPTqtuW9tLByjnUs9k4kYwxmpjyhrNUKebOJVqqGEbO/ZwwWaABHg83NensnNhj/MVAxDAVJq5JxCLA1q5bOHAJIlBMOs3XuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc4Ofrzvyxe2YIpJQMB93EvDF5c+fNFeVsHKr+ypkko=;
 b=j+m/pXEbqEs9R/392tWwVzdwx22nQeDyW9zx1vB0Q5FfEiJzz8Cu9CY1CvgIOfYlP9bOB3ArjcBvNJ54UWt2FWA9+Cr6v22mTzD82fMmSmlUWdWruEqw0key3zB7hwch7u+016RPXP4eialn5mlp/ol+G7xM1O1I2eiSiGxw30A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 19:06:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 19:06:34 +0000
Message-ID: <ad50a249-008d-4d1d-b6d5-cc09f815bf31@oracle.com>
Date: Fri, 1 Dec 2023 19:06:30 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] iomap: Don't fall back to buffered write if the write
 is atomic
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, Ojaswin Mujoo
 <ojaswin@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <09ec4c88b565c85dee91eccf6e894a0c047d9e69.1701339358.git.ojaswin@linux.ibm.com>
 <ZWj6Tt1zKUL4WPGr@dread.disaster.area>
 <85d1b27c-f4ef-43dd-8eed-f497817ab86d@oracle.com>
 <ZWnfT1+afsZ9JaZP@casper.infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZWnfT1+afsZ9JaZP@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 717de908-76bc-4bed-0318-08dbf2a0a2a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wQd39MBCyb9XfKo4XQ4WiDnfJRAWOMtuBOhpB/ZPSBwc8kUXMYxDvsY/tsBu0zRRVbA+hx6fxcbIpp9x14uX06HVTKllllgM48oexcqHJIVAfwmKROIedO2Njcv+MMxTBZ+iL0l5sQ9KSSH/TlVgvycHUvD63LGhpRsH+/z9qoc1SJxo+C8spinzq2mrfizJM+T6AWxlGNibDXM6K1ggbjr4ENjZNNxmdcnKoz+T1seRWW0uU9IZke+ZYjQYzc2x+HyiYnBmdGLX6yy+XW3GMcBLV5Q7jZFd/qgxTfjIa89wmDbtjmtu1axd77M799cglB3QR020Z1sIupH6rRfc7ipSpmhlFdUZ6JW+U7gmNOdQ/3SDBDPzxfOCZ678hmahzlN3wP3ReB32LJuvVtj32CcJ+Ib0/CMEA61igHW+bIe3HS7KH7E2Q1lgBAxzhYKw1hC/Gt61XgaJhiL9s+HGaPqcsungLmQ4YBx1Oa77nZaeQpy/7h4AVwFJ9Np5oZk2L4bXO6VqH3lRXwodl/6yOoNLXFT2IkQ4nMR5uy+Xxnt4aSVa/hKJWqd13PM9m06F3jOzQUuh4rHj36nQieNqSo6iXCtrzjFX/veaAvO6fwuSQC50AxQJe96MHKqYtjRFr2wF9KeoHLWl16pgGsOubg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(26005)(53546011)(6512007)(66476007)(5660300002)(7416002)(4326008)(41300700001)(66946007)(6486002)(2906002)(6506007)(478600001)(316002)(8676002)(8936002)(66556008)(54906003)(6916009)(31696002)(86362001)(36756003)(38100700002)(6666004)(36916002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3UrZEovTGc2Z0V1SVFFTnVwRllJUExyMUo3Y01HRUNTemlMSEJWaEtxS0xM?=
 =?utf-8?B?YWVEOGVoV1EwOGdmNDdVUVJHdU1BanEvWlh2K3dJY3doMWdjUGUwMHdOZ2d3?=
 =?utf-8?B?aHlPL3B1a1F1V082dURONmt1ZTRxMnYzOXZXZkdvLzg3WkZjaDY4cDZSNWVK?=
 =?utf-8?B?NVpuNGQxWUhSRzZUeUZtaEk4Z25xVlIvbXcrRXdCVjQrbVI5MTV2OVdXTHBX?=
 =?utf-8?B?TGJBMGVVamc0OUdIQlRSZTg0ZWFLdFE5MExqd1hVRmFvNFRScGdYQ3JCcXI2?=
 =?utf-8?B?azYvYmZFbXhPTnpVbWtBdGVUOHBWUHlEeWh4RW1CdWN4NkN3L0hKWmFnQlJS?=
 =?utf-8?B?dXZYOVE1WXNBbVdRZVVLWUJRRXJxNDkwWmVxa1J6azBLa1BNMVIxeDhNYmtQ?=
 =?utf-8?B?U0JjZlhXVWd1aFJXeTkzTGt4Y1ZuMko0dWpHdXQxaThYTnAxK1FUZ281VHlK?=
 =?utf-8?B?V0t0QVNoMVhjd2hFZzlsZnY2YWorSUlQN05sbDhyQnM1TG0wemxGNFluRnNo?=
 =?utf-8?B?SUNhTGJ1U2paMHRqVCtlWjhIbmFhcUdjeVFxdGdWcktJS0VFTmZHN1pJczQ1?=
 =?utf-8?B?dWMzbzNHSm1XZjYvdmZqU1F0WWlwbzhnNkk4RDJ5UklraHhSdFF0WXdlNlBX?=
 =?utf-8?B?Tko2YjBlU1JIUk5wcGtCZmhxYTRrTG9oNW5tM2c3Qk5EMU9kRFd5MWJWR1ow?=
 =?utf-8?B?L1BUMk5aZ1JYTWtLY1FDS0I0clRJZFV4S1FCR0ZXTW8zZVgxVUN1OE1IQVpk?=
 =?utf-8?B?cTZrN2c2OXMrMGlKcTVZY0RidTFBRjZySXMzVENwcmVvL2ZlY2g5MVdpa1Ny?=
 =?utf-8?B?RG0rcUJMcXhBUWd0NmZTL3BPRy9sVXdGMVdlMURzSUttaWJlaFFqbnNmeXZl?=
 =?utf-8?B?NU90aWFKMWFQclk0VXViSDBvVWhNbDd3YXh4eWMvWStweXFDVHJacXc5QmIx?=
 =?utf-8?B?UlpoQXFoclpPNEY4bzgwRUFielRzSk1qOFZ0RzdrdDl2ckJBbmJYMllpNEVv?=
 =?utf-8?B?Ny8ySW1PY2R1TXJaR1J5K3Y5b0NuQW5uTzkzZmErRkErN05naXpGaUFyTjlv?=
 =?utf-8?B?UGJIOXRRYTdGcnRaRzUzOGo5WDhIYjdtbFBCL0lwT1Vnd1ZMc1oxaFI2bmU0?=
 =?utf-8?B?em1SaU9qdldaVklSS3BNYXpSZHRkTlZ3NmxEbEprK2ZtM2Zrbjc4TDlRUjZI?=
 =?utf-8?B?ZnQwb09sZVFoWkpjTnhEd0lxTzBUb3FyMitCSVkvZG9zME5jc2RneWg2QzBt?=
 =?utf-8?B?a2QzSTZHUHVLVXBhdEc1WXRCcjFyeVpiV2lJNU5GMmF5MStGMGdUTGV4MlM1?=
 =?utf-8?B?ck5JUzU4YjNMTHpnbHdDclJIM0JUNmRKUy9NTVpGbk9laXp2eXN0ZVMwVlBR?=
 =?utf-8?B?WmNQMk1LUHc0SzBPWnAzbVorNDVCeVhVMzlML3NraVFXMmdjcmlqbm05cXJa?=
 =?utf-8?B?SnhzZjNuMnNBNzlxcHVzeUQ5czJTVVVrVDdYK1pOZXhDZDllVzQ1UnR1ekUz?=
 =?utf-8?B?QStiYXluYVRxV3NtMy9TaVMvQk5xRG9oWDNhdU1IdFdkTFlDcEptNm8vdlgv?=
 =?utf-8?B?VTdQZjhuTXQ3aFpOV1dCemw3OHhKWkt3bEZYMXovWlJ0L2dSQkpwL2dQUEhS?=
 =?utf-8?B?N1dFL1RCMk9xbURGRDZBTGtYRGMvcm9NMnZiT3EyU250bkJMNXRBbEFHMUJj?=
 =?utf-8?B?UHpXNHh6SzFUa1Q5dy96c2FrVGQ1R0lCb3l6MWt1U0FXaFEzSVNFN1EwVXZM?=
 =?utf-8?B?WE1Ddmk3U25PZFRLcDZBdlcyTUVlclh4cTMzUk92dTkybFFoU2VwMk9VU2k3?=
 =?utf-8?B?d3RoaWhYdU1QSjJEMTNpcGh1UUdobnNWbktqVmF1RlQ0N2htNkpFMHFtUldW?=
 =?utf-8?B?MnMxdHZGQzE0WHIvaDFCUkZSdFF2REZCc1hXODJrRDV2RkVFMzdaK3B0eE9p?=
 =?utf-8?B?R3k3QmE5K3F3MkFaZEhtOXFtV0hBL0tUQ3c1WUgwMXduZnFIcjNEdG1lcE1I?=
 =?utf-8?B?L3g0NFRrN211ZnlMbWozREYzalFFNDRBb2M3eXZLbEdLb05LL1RHbFVVNS9S?=
 =?utf-8?B?Ymd4SDJnaFRxMDJvT3laNmZmOVJXRDg2WHJGS1BFcCtpQkc1YkxPd2NwNlgz?=
 =?utf-8?Q?qtV7l9VkB01aV1xYGQ2x2W8WJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?WUJZQlF4WUFaQ1VlUXRUWFU0SmlZV2R5TjZ6azd6RjBSYzh6bXhldERJUUh5?=
 =?utf-8?B?SUhiUUlub2paK2sybTNwVlQ2akxXeW1wKzRqSkpqWm54YmZaLys1S1I1N0pl?=
 =?utf-8?B?emJSLzlsY1c0UUJqbG45YmtaaElISWIzbjdsOGtrWE1Lcm1oVTdTN2UyemtR?=
 =?utf-8?B?K3ovSFlwU2NydzBJMGFwT2ZuTFhPdHhHaGpwTU5MaFdXVXU2aFFZdTFudTdu?=
 =?utf-8?B?QVJkZjFYR292WkExWnM5MFB5OUhmQTdKN0JVbzBhOStNRlY0VmFYS29PempR?=
 =?utf-8?B?Y1lTdFVBL0c5WDJJR2dSbXpIdTBsWWhZZEVIZVJ1SVRBcCt5c0hmelAyajFI?=
 =?utf-8?B?RWdraWZBY0RiVG1OS1h3WCt4d0JZdnFkQW11cWhVUDRsZkU1K1R6ZkhLbCtH?=
 =?utf-8?B?Zi9UMnhPVTUyTFRiMVRjdkpuRmpQb3ZCa2lTRW42Z0lLNFZoRkV6c2ZTQm1h?=
 =?utf-8?B?NFpBNm5aVkd0Wi96UmV6K0lyd2VzMVhZUVdPck9VQ3hCbkhUOXBaNWxSNHo4?=
 =?utf-8?B?ZFN0YXJqL0huSkJVaG9kUStLNkZFejRWU3p6VUJWWWZKa3dXRnVVdDViQVQ5?=
 =?utf-8?B?bTIrTG9zZVQzVVJId3lvRnhtcFlVMExoR3Z1d09mQ1ErUktEMWFtSVpDMDRo?=
 =?utf-8?B?eVhoYzFORzhwQU1VYmkyUXIyR29oemxGdEJBbnRLUjZDdDNMZkVWMFMzaWhG?=
 =?utf-8?B?bW5PWWJGMk50UmJFUmlMUmFMU2xlQVA0d29kMENiK1Fxb1hvMUZ5Q04wL01m?=
 =?utf-8?B?cHI3S2pHeFZCSk5FeElMU1dZVkhIQkRIUzZZNVZDUzA5Rm1KZG5xaVEvL0lu?=
 =?utf-8?B?a0ZQb2J0cUV0WGpJOVZhQy9BWkxUZG93bk1VaG1SZmtmOGJ4YkkyQ1JLdnNI?=
 =?utf-8?B?QzdkSUp6Tko1ZzRkai9icDU0QWpPSmdHU0UrbjhISVd1c0NIZDd4MnhXTFRK?=
 =?utf-8?B?UWIrbnd2bmV0UHdYaENOMUJVelNCSEg0bnhoUHRCZVgwamFaU1ZHS2duYTIx?=
 =?utf-8?B?Q0VsU3JnSXNET242YTY5S0lwcmRuVm0wQUZmRDUyT2ZOTHArSG8yWEkraEN2?=
 =?utf-8?B?QjNPWUVCK3hyUzl4MkhNMGw2b1hLcHhyU2RncWxKNWlZT040ZjNHR2lEZGtr?=
 =?utf-8?B?ekpxYlVMakh3NWlLRGJQZDdGMUdYaWkyemJPYU9qNGNFZmRaSEtteVg0empQ?=
 =?utf-8?B?SzExdnRHZHJFc0hjbVhHc0ZNNUVIRHdxZkVFQkVXOXczb0pjbTJ6bXZZUmxs?=
 =?utf-8?B?Vk9YaEE3bGh3eWNCak5CSG5BNEFQRVIzZFQ3UDdVeWxUbkpjYnBUUHhxaFhG?=
 =?utf-8?Q?SIsxq3rLOJRAM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717de908-76bc-4bed-0318-08dbf2a0a2a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 19:06:34.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kK9Hmz+kz+VbFU0TC6oxTntADTMiw2i1Tv2utPVYmjJIvL2Q/5F5XbJsCFeO8K0WgZ6lBFFYsyVDFs1w/a+jBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_17,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010123
X-Proofpoint-GUID: v3pTaMEEes1BZ-5fcLoU9tDhk21ZEeB3
X-Proofpoint-ORIG-GUID: v3pTaMEEes1BZ-5fcLoU9tDhk21ZEeB3

On 01/12/2023 13:27, Matthew Wilcox wrote:
>> Sure, and I think that we need a better story for supporting buffered IO for
>> atomic writes.
>>
>> Currently we have:
>> - man pages tell us RWF_ATOMIC is only supported for direct IO
>> - statx gives atomic write unit min/max, not explicitly telling us it's for
>> direct IO
>> - RWF_ATOMIC is ignored for !O_DIRECT
>>
>> So I am thinking of expanding statx support to enable querying of atomic
>> write capabilities for buffered IO and direct IO separately.
> Or ... we could support RWF_ATOMIC in the page cache?
> 
> I haven't particularly been following the atomic writes patchset,

Some background is that we are focused on direct IO as the database 
applications we're interested in use direct IO, but there are other DBs 
which do not support direct IO (and want atomic write support).

> but
> for filesystems which support large folios, we now create large folios
> in the write path.  I see four problems to solve:
> 
> 1. We might already have a smaller folio in the page cache from an
>     earlier access,  We'd have to kick it out before creating a new folio
>     that is the appropriate size.

Understood. Even though we give scope to do atomic writes of variable 
size, we do expect applications to use a fixed size mostly. In addition, 
typically we would expect only atomic or non-atomic writes. But what you 
say would be possible.

> 
> 2. We currently believe it's always OK to fall back to allocating smaller
>     folios if memory allocation fails.  We'd need to change that policy
>     (which we need to modify anyway for the bs>PS support).

ok

> 
> 3. We need to somewhere keep the information that writeback of this
>     folio has to use the atomic commands.  Maybe it becomes a per-inode
>     flag so that all writeback from this inode now uses the atomic
>     commands?

I'm not sure. Currently atomic writes are simply flagged per IO, and 
per-inode atomic flags are something which we have avoided so far.

> 
> 4. If somebody does a weird thing like truncate/holepunch into the
>     middle of the folio, we need to define what we do.  It's conceptually
>     a bizarre thing to do, so I can't see any user actually wanting to
>     do that ... but we need to define the semantics.

ok

> 
> Maybe there are things I haven't thought of.  And of course, some
> filesystems don't support large folios yet.

I may consider a PoC...

Thanks,
John

