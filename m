Return-Path: <linux-fsdevel+bounces-3831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83B7F8FF4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 00:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 188D0B2105A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Nov 2023 23:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF53159E;
	Sat, 25 Nov 2023 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLcH5N9m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0RETeR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B7FF;
	Sat, 25 Nov 2023 14:59:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3APMOptv015652;
	Sat, 25 Nov 2023 22:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cM0y9/33HmXtQ/Pxit5XAtV3y5cEAuBRiqLjZPq4few=;
 b=dLcH5N9m1C0dH0FNpDLyCERO0FvOGRC2XwIfnRSfWjrZu1vH3ChkKTjSBJLuTIse0uUx
 cOpVCk5HhYyqK33klZGvgHql9jvf5fAJzpLdZ+QMOoPbP/delagrz2w3LUaaETyo5gFb
 yqkd6l4qZ8pKOuZ/lBcNsNkyX4/qEM3G6reaEGK62VGT/oTS1csjEgIQDydmCjQwl2uS
 ZIEzR/17kj5w2p3qhE/QWuqQl1PVCoE8iNGzH+07HL+EgjVeivBHkgKL8pFBoc7jZYf9
 5IEe0yZPxp/IbvRjiwDfu0X1D7Vh3JxXXz9mG8GwlsJM4dOz+I7T1KC4Kgf8DUCUgf02 Xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7berpmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 22:59:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3API0TL5012786;
	Sat, 25 Nov 2023 22:59:51 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c9hje5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Nov 2023 22:59:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx72qojYiAEqZIck7vVtxAu4aPNObXBYPaM3nktI4Qd5Ve7yXxvHYnDE6ACsokXKbfeEkN4owZ0W33e+RehbpS3ThbaCHErRhC9D7ltsOzsTP8Rqru+Q1pQKCTvMDiSo8pQS0PyvSC9ttWrmFv7yRVuBm4mJ4TbqqpEWuxihG5AIizPhU51+fDHDkpR/KHjUmyQXrpRrUfmhLQI2qYLbZuODlt79XuzXb7ezOmeI5lbGhrtyxvKksBatAeFNs2osXiKCZJDi3FUIW2y6NflKNApvUgn7M7eqInlBfW6k/UV/zD3BQgNhYSD28kv0brKiovTwVmuXA7EJLT+hScYFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM0y9/33HmXtQ/Pxit5XAtV3y5cEAuBRiqLjZPq4few=;
 b=W3HU8t92rzbPDS25BX88JcT3SOmyypWfEV466mumUBnwOZx8cjFr8hUqlbfAPJTitM5Qc1jJb0V/7Nby3mKijJEqOMsYPteFJdBExvADxIXWf89p218hCTh3w7Tw5f5l9HNY1qSb6zhf8J7yFh91cvPDgIEn0qEtIpdNz5al8OrxGzzUUE7hcVdpto/VR+FHKNHpTrvObUqeGvPvN10wdyGudj//H5FuqtSmwqgoi1e5RNWZZKBrXOAT0rNFtsZaORCSvTrS+0arlEXgk0cjudlIRN1puhQJMAq8yEfZjcURSr2mmbwMwzpGjepN7mnZ5sF+qR8i5wKvVpltFhDLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM0y9/33HmXtQ/Pxit5XAtV3y5cEAuBRiqLjZPq4few=;
 b=V0RETeR/Q9Rf5pzmNfLJwgntk4qwKmyW3ozH8Ubu0Rq40HdzpwvE80t6MqoqiI4xac20bgXPLQ5sGWVLqoq0g+6gZpLqdGpGdbjPUBOKLQW+kIV6epdcjSY5thVbEG5FU8AL3OexL/0moYyOF3byXSoUbUe+X2ANT9OTpWYc9dg=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW4PR10MB6396.namprd10.prod.outlook.com (2603:10b6:303:1e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.25; Sat, 25 Nov
 2023 22:59:49 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2000:9c78:19f5:176a%3]) with mapi id 15.20.7025.022; Sat, 25 Nov 2023
 22:59:48 +0000
Message-ID: <531f8f07-6c4c-66bb-1d8e-7637222154af@oracle.com>
Date: Sun, 26 Nov 2023 06:59:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_use_block_rsv
To: syzbot <syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com>, clm@fb.com,
        dsterba@suse.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <0000000000004d4716060af08a45@google.com>
Content-Language: en-US
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <0000000000004d4716060af08a45@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:3:17::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW4PR10MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fc17195-a823-4691-34be-08dbee0a393a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eQDz4wJ4hW3BJOhIfMJamqECtLSr5XnaoiDPrUQTF9fhH1pl5scUyXoLLWVfpWf48mQUwYC2ybePYLuRUaB4yjV3731huE53QobiGvcOMqRBo6j47W6/UZfPfhFo7OV1u9HGwe/Q82IucIu7ztncT5tCPA2TphfPmxQz3969cewbeWJcXUIujhO3rPnDZ2g8f5RmzicOKRI9vv5B0lDxfhw661ktLUSY0aKWPXQpbPaS5BbW6TP3NAxs7zD62pMgs8JkmXz2Wt5/XZ+G4wXlxLim+oSXxFf1Di0SmwKEAagShi3J2e5v+5niphRBSDydyxKAsRKFWPLogDxvpnskKto4oh2iGhvjOSsl/EDJ03mCLFlMKN2Aqn5wKZ3m6YGWKsXtRgcquYoyqfrin7+9g0hgL6tS/q2DCDkowNljZknDM/Pu+NC+ZaXRVpkLMSkZ/ytqMmOaShxZ1I8qBmnmgi1b+9Kqwc0DMiKlGRn3Y+ktBd8nmXlkedtKk5pQ4+QPAkSnw/n2PqUdmHqGoUnhy9cCh98AhqbBpZbCuedfl0Zkf6w+3rWM/T/j2oMJhv81t7/j1LDd8F4sejSnLrK3t6tymvuPcdIh1O9FQmqsKTURjoRMv7zbxbAzVPUaIWc7/vrVr/LPNL8d+heBlU4EeC4+COSZyT8OFeUZ7ihzdspgAgT80b4SnZ0U3UhJtFLmhJqJ4c+5cNjVNMJ8nkmSXItO731UqJfUqpG1ffu0uNuGIsZsuqg3s75rpsy92MBU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(38100700002)(36756003)(86362001)(31696002)(41300700001)(316002)(66476007)(66556008)(8936002)(8676002)(66946007)(6512007)(53546011)(966005)(6486002)(6666004)(6506007)(478600001)(5660300002)(2906002)(44832011)(31686004)(26005)(2616005)(83380400001)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c29qQXBKWmJ1MUZXTFExOTh4MEgxRG9TOG1oWXdaM1ZsU3Y3eHZTd2lML0Fh?=
 =?utf-8?B?czZYQnRvR3FoOHhETzc2Yll0aDlZVWpzM1M4cEhTN0xmYXpSeWxEdkRxc1hJ?=
 =?utf-8?B?ZTJoQVM5OHRCRWtGbFVNektmRDk5aW9RNFg0S3U4TFRKTVN0TzlkanJOaytD?=
 =?utf-8?B?M0JVdUxoUmh4VnQxOStZcmdTSWRKcXkydU1DMVZ3MlRjRUJ3bTZnTEdQSGdR?=
 =?utf-8?B?aWozdnd1UzdJaWxIbkVHS1IzVDRNYXRlMUFoaXRoUHlTZGJydFM3NGdUWmFx?=
 =?utf-8?B?S2FMdTlIK1E4ZklPeDV3NXN6dHVCNVIveUYxVXk1NVBXNWU5Y1YyWmpzWU1n?=
 =?utf-8?B?c2w3ZHlNUSs1Z25mWkZBM3Joc3NiWnM3Vk92RjRsV0Q5UUVQMnJKRndwcHNl?=
 =?utf-8?B?c2R5QWhSOHFuWmtHQVFSclpBaDF3MFNzTTZyb3d5SFE5NkJEakI1YXo4M3RM?=
 =?utf-8?B?ejRHQjQ0aEF1V1liQnowcDNIbmdpVXlKd0Y4WU5MRVdyR0tTWFZjWERyc00x?=
 =?utf-8?B?Zy8xT1hKa2twbUhEK08rMFZBK1NlbklsOWsrWkxVckpzSzBtcXd4QVVzcUY3?=
 =?utf-8?B?OWtpaWNJWE1QVGFXc0lyM2pVL3dhM0JNeVJlZ3ZQcnNyQldraGh5TVJuL0ps?=
 =?utf-8?B?VklqYUZ1TERxZkxzNEcraVgrK2dUZWZ3S2FBbnBPNkJBc1pIZ0g3a0V2NmxK?=
 =?utf-8?B?WENhSkJxUzUzbHBUSU9BTTBNckVvOTBQTEc1NUtoWDFXdThXU3JuZ040TWZr?=
 =?utf-8?B?RlYxNys5a0dwNG42c212L2FPcDEzM3JnWWlXZkJ0eC9wajdwajFlRFZucXFK?=
 =?utf-8?B?SXhTTTY4eVN3NC9VZGxOemsrWldZQ0tJa3VaeFIvRmJEWUlOZjA1K21mNjVG?=
 =?utf-8?B?dCtsLzIxdUQyQmZMOFR4bU45WmJ0N3IzZmZCYnhWdUhORDRoT3pwTFlKMFhk?=
 =?utf-8?B?WEZQNGxCZ1M3ZmhCamdEWU5XNWVBbGxqZUtDRGpwekRxcElmTHM2L1BWK2ZW?=
 =?utf-8?B?dFNpZ1NIVmpEOFpnaUtTQjlSM0x6eUtZdkVTcGVyek9IWmQ3Z24zU1VpcnJq?=
 =?utf-8?B?ZWxVNzMwa2NlazVXSVlkSHdXNlh0TjVMeHo1ZHRYdG0wM3RWdm9CSmJoMkhY?=
 =?utf-8?B?UjJPbWhZVGNaNWNKaENPZlFUdUI3aDNrZlp3cDhKQURvdnVLNUVMdXBTdWQ0?=
 =?utf-8?B?dWhORXpEU3N0TFdFM3JsNm12L0RDS3k1R0Y5UzU2SVd2N3FHaFlldnF6Z0Nr?=
 =?utf-8?B?cWdBRFhPL0E1K3Rta3FJMWVRdHlzOGpmQVJNNEpxdFVKdjF1OU14RmJkaktT?=
 =?utf-8?B?WU9tOFlIb1lqQ3ZKWHZvWW9iTE5NWkxkeVJYbE5SZVUweUk3Z1dtYnRwNEhX?=
 =?utf-8?B?cmw2Z1ZGRzJXN1oyQ2lzdDJpZGJJbVdESUtBdmlPa0FKdGxkUHBGUFFVUDEz?=
 =?utf-8?B?S2pxRWtxbXh5bXBjKy95WjBiZ2k2Rk9Rbk95UU9YSUgwZTBOeGVrRmxNVGtL?=
 =?utf-8?B?cmM5SG9QRTczVnE3aFViNDJFTVZJWGVZM3RwTGs4WlJFR250RTdCKzFmVVhj?=
 =?utf-8?B?bE1ZT0Z1bWUzb0NwNXR0UnZ1cy9XOVFFeGc1Wkg1TkJPaFNEMjE3eHpOaUMv?=
 =?utf-8?B?R0tiMFBtSmxZOXpocTlmZnlvcFhLRUluVDhKa3RZbGdta0RIbUc1bCsrSEJx?=
 =?utf-8?B?TnFpWENGNzlHM0t1c1RuYVVTa2NGTjAvNndYRXphcWpEYlp0RVlPV24wTlVt?=
 =?utf-8?B?eFdFZEd6RUhxZFY0WFcyeFdTVE5UdEx5NmVwUkJyNVdwcDlJWXh0cHB2MFVO?=
 =?utf-8?B?aWZJL2xTN2RUL1dmaXkrdm5ZbHBrQ1pUSkNTaUU0RU1UTXpIRHBhaHJBRUxR?=
 =?utf-8?B?ZUhmZTNNNXNhRGFOcVd1TFhpUGNNdHhFMFhJWWwzaTYzZ2tqV050d3d2ZTBG?=
 =?utf-8?B?Ukw3cEVZVStuNDhMSnpzNnpUUitiZU0vb0R0YzVYb0NBQk9IdkRwZnRGL0dr?=
 =?utf-8?B?Y1NYMEJaamlIVlJuR25TdlNvNUF3SjE3R2dTRm1MTGk4VjY4dE85MWRadFZF?=
 =?utf-8?B?ZVhYV0YwS202VnFVb3hjbkZUdm9VVGJ2cXJacml1Vm1Mb0F0VUhJUzFxMXdJ?=
 =?utf-8?Q?1o+cDaeJuvfXi8RsyZoTkEarp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?b1RsYnJGQnRKY0FzTHZROHJuN3FWaDBMazgyOUUvK0ZtRDg5U0VvUis2QW9z?=
 =?utf-8?B?dDRITElGNWkrQ0g5T2svbStVNWxuOVhKOFVKUytRVktEY3Y4amlsTnExVEpV?=
 =?utf-8?B?dTRxT3hzLzFOUlI1aUVYZzhJNmpIdHY1aEJtekdMeHh5dmlzZ2VnZ2poMitC?=
 =?utf-8?B?YXFGUDE3aFJDMzNDMDZSeWhOREZ2Ry9NNGpRdzFzUlVVNzNBd3NRVk1sQ1BS?=
 =?utf-8?B?SkV1TCtGc2dkZy85Z1pySTY2ZlR6c2pmREhmVE4vZzMwb2pxYzNJR1hoUkE5?=
 =?utf-8?B?a015NTdyNTdHSmxPalplRVhMM3piRFJiRVV2eGw2Y2hJclRmdUJVTWxvZVZl?=
 =?utf-8?B?MWEwTjhFWDc0dEFZVXcyTzYrcmgxQXY2WG1COFQ4U001LzkxRzhPRlVQb0RL?=
 =?utf-8?B?R3laR0tDQ2hwS2FJZkdxaFo4MHFQSWlteVVCUklydUpDUXgrRVo5Wkh0dzFJ?=
 =?utf-8?B?bXZ3U2QyVmsxNkJKU3hCZTNoS3kySGluTkJVSFpyU0ZGbVBGeFljNTZReGtI?=
 =?utf-8?B?MWZlWkdtRHdUY0FoSE9ybXFtWjdpNkViQ2psbEJFcmQybWdTcW9JWjUrSTRR?=
 =?utf-8?B?V1N3WXJlWUtwOHpxb2x4bXVqMGd5eW5rRW5wUkdmc3U3TzYvdUZuZUVjZmk2?=
 =?utf-8?B?RTBIVVNqUldURmlpWWdUVUNtaTRqdjNBVWM3cjhUMCs1K3FDNWtDRVdDVEQ5?=
 =?utf-8?B?ZTBwYkZTZGU5dGRKSUI3S3BPZDUzZ1AyekVrWHh0WFZMNDMyTTlKWEVXNFJE?=
 =?utf-8?B?bTFEWU9uNHNpQ3hEQThuRTVST1NxTTBCQnV6QkE3ckMwTDJpODRvUmpDZ2lh?=
 =?utf-8?B?M082MVBsRURZd2lVUWY5VllzZlpkWkYvWmdwV0dDNU1yZFFXZmUzamd6empr?=
 =?utf-8?B?L2k2b2t3YUtrcjQwMGU0T3hwelBHbE5pMzBIeUJ0WmE5QXdrWGdDV1dGZ1hz?=
 =?utf-8?B?QXFoakc3SVZzRkxPZWlLUGZMWFE4cWV2aHRsdUZ2RDgydFJnTk1RYnczblVa?=
 =?utf-8?B?eE5HancvN3ZKd01qSWkzbTk0UXUrbmxucDZPQUdmUUdGRFVPTEhWbmFDYWI5?=
 =?utf-8?B?UXFSSzhtZmNGbTNSZU1mQ0FLWm5kWjg0MWVJeTZpRnErR2FFelRvRVdOUyt5?=
 =?utf-8?B?cTNBVDl1Z09meHlTQUNLQTMvcERFSWpnbk5hWFhpcnlVQnJrdjNud3IzMXBX?=
 =?utf-8?B?VUtIcmNtRUhhRmM2ZGNxR3Z0SkJWN1pTNjlqWHRSYTUzOGtVUFF6cHp1cGZO?=
 =?utf-8?B?RUFHZWZWT1N0cDJ2c3ZXY3JCcmNKSjBocnZuSjFHWExwUHVBQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc17195-a823-4691-34be-08dbee0a393a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 22:59:48.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0tcuKAUa19r+MOphv+xIfgcs8uuIvg/Gk4PcrLd/kO7bCF2eWYyIvHpqUKpWijLNtVbMhQD5YFel3O9vjTOkPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-25_22,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311250174
X-Proofpoint-ORIG-GUID: k_nJYfHz7jf6zyEdmtwogRvTiNS1OZAc
X-Proofpoint-GUID: k_nJYfHz7jf6zyEdmtwogRvTiNS1OZAc



On 25/11/2023 10:08, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit a5b8a5f9f8355d27a4f8d0afa93427f16d2f3c1e
> Author: Anand Jain <anand.jain@oracle.com>
> Date:   Thu Sep 28 01:09:47 2023 +0000
> 
>      btrfs: support cloned-device mount capability
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1446d344e80000
> start commit:   d3fa86b1a7b4 Merge tag 'net-6.7-rc3' of git://git.kernel.o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1646d344e80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1246d344e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ae1a4ee971a7305
> dashboard link: https://syzkaller.appspot.com/bug?extid=10d5b62a8d7046b86d22
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431040ce80000
> 
> Reported-by: syzbot+10d5b62a8d7046b86d22@syzkaller.appspotmail.com
> Fixes: a5b8a5f9f835 ("btrfs: support cloned-device mount capability")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection


It is completely strange that this issue bisects to the commit
a5b8a5f9f835 ('btrfs: support cloned-device mount capability').
I am unable to reproduce this as well.

-------------------
WARNING: CPU: 1 PID: 58 at fs/btrfs/block-rsv.c:523 
btrfs_use_block_rsv+0x60d/0x860 fs/btrfs/block-rsv.c:523
<snap>
Call Trace:
  <TASK>
  btrfs_alloc_tree_block+0x1e0/0x12c0 fs/btrfs/extent-tree.c:5114
  btrfs_force_cow_block+0x3e5/0x19e0 fs/btrfs/ctree.c:563
  btrfs_cow_block+0x2b6/0xb30 fs/btrfs/ctree.c:741
  push_leaf_left+0x315/0x4d0 fs/btrfs/ctree.c:3485
  split_leaf+0x9c3/0x13b0 fs/btrfs/ctree.c:3681
  search_leaf fs/btrfs/ctree.c:1944 [inline]
  btrfs_search_slot+0x24ba/0x2fd0 fs/btrfs/ctree.c:2131
  btrfs_insert_empty_items+0xb6/0x1b0 fs/btrfs/ctree.c:4285
  btrfs_insert_empty_item fs/btrfs/ctree.h:657 [inline]
  insert_reserved_file_extent+0x7aa/0x950 fs/btrfs/inode.c:2907
  insert_ordered_extent_file_extent fs/btrfs/inode.c:3005 [inline]
  btrfs_finish_one_ordered+0x12dc/0x20d0 fs/btrfs/inode.c:3113
  btrfs_work_helper+0x210/0xbf0 fs/btrfs/async-thread.c:315
  process_one_work+0x886/0x15d0 kernel/workqueue.c:2630
  process_scheduled_works kernel/workqueue.c:2703 [inline]
  worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
  kthread+0x2c6/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
-----------------

btrfs_use_block_rsv()
<snap>
         /*
          * The global reserve still exists to save us from ourselves, 
so don't
          * warn_on if we are short on our delayed refs reserve.
          */
         if (block_rsv->type != BTRFS_BLOCK_RSV_DELREFS &&
             btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
                 static DEFINE_RATELIMIT_STATE(_rs,
                                 DEFAULT_RATELIMIT_INTERVAL * 10,
                                 /*DEFAULT_RATELIMIT_BURST*/ 1);
                 if (__ratelimit(&_rs))
                         WARN(1, KERN_DEBUG
                                 "BTRFS: block rsv %d returned %d\n",
                                 block_rsv->type, ret);
         }
----------



Thanks, Anand

