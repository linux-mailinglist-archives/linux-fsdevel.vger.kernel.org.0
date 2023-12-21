Return-Path: <linux-fsdevel+bounces-6654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDAF81B2DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 10:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813191C2338C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 09:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BA64177F;
	Thu, 21 Dec 2023 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WiF6F5XM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qSBxOZkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECF3B790;
	Thu, 21 Dec 2023 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL9UmFg017275;
	Thu, 21 Dec 2023 09:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=10ufrK7mxF5xXsYnwagHvPtChCOfBSl6vNKNSRbXKoI=;
 b=WiF6F5XMOwU/ocKZdaJMkZ0wSccAw33nDXiN8GQPm4Ss+bveSkb+3i4O64EPw3wfO1Yq
 StRUzZ5lfbqIWrtlhOjr9zYoRNQj4S2fZ6vewtMqxj6B72bcSulGpyh8wsDOmtvPqAI7
 npn78e3frM88F6Zo2aPjWz8DwP7/Vqrl1gbLag5RgbYDGE3TnEPx4G7R1RYHOKqbVxuw
 jA51L3nls/EHDBKTCwzSrrrACbmjAftvFoOUKr0te6T1NDG23hTBDzRqjjOlFVT/IIal
 pz1H9gee9lOgqL+OKJrzribSP3Wlw/2Kun8bWDlbiZt5rpOO329B/S0ITqTVcJQhZIi8 fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3v4b488qdq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 09:49:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BL9gkgn001665;
	Thu, 21 Dec 2023 09:49:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3v12baea08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Dec 2023 09:49:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPXelk8OjKzmacXb1RcBEIVAnJ20edX4J0xmEvRdSMil1TOoeATCjBRU1kzJoICF6N2/xq+R6/h3bRf5lQVXp6Xuo1Q3RDfW6RVY92RyhPHghJUa/KeorsKeOwtRaBAhYKpur2Zx6nnt1A2YFOZPYUvvkv+dvRNKdXbz7/bCRFOCKIPoLckm4AfB9XVn5tmQJZqrdj5MtfIEV+lKOo1O9Yun77NABFNQcheTRYdJGuRn8woRePQQ8zNNM24E+nS2DbPZrJHxMdHx4xsinWPcBX1XR7wfqorcnqcOdhMcArr2hHFq0+ftSIShkq4NNtLO2LAyKJMJyWa7xFoi29Moug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10ufrK7mxF5xXsYnwagHvPtChCOfBSl6vNKNSRbXKoI=;
 b=URFXV8OG92OWRFhG82FSbAqWfZF+BcWrb6hO2c3cK18H2McTAYkavoYviye7NaApCg2q1cfMTuCe8irGXKqtx9VNoFwQh0HW8iYJ1RXXUPSE8msfpLRsoWjMpwt0ZYSFiXidiy6FXSiCxq1gZTiKvbEOxq6jzBYyKP6VOVKXXZ2xJ15jf6qO88zfsdk8nnbTq4m5IU95BDyAkPRCK9Ice+EekYzw6fSs0TWGABRl93PoKevhO3wmMETINdZJrZOd6p11FENeTYivpgVzFRSxpD9KEEYwjNh3nM2fBjrazu8YU3C8mLgDYUjjGT9RAC2DVJ5kCamfT8WipymC7zgYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10ufrK7mxF5xXsYnwagHvPtChCOfBSl6vNKNSRbXKoI=;
 b=qSBxOZkHF4qm96UdAwzRUJ0lw2GVTkcdTURM6AfiWH9ovvEHLxW7CrTXBBwRGnsT10Ob9bQylRMTiZA1+i8djEzxQZJIaR27FbjJMiS6VfN3ytyaQApjvZNENOkXTmqu6AwFi7rtoDPKT6/sOQNJYIW8bO/VSaQy1tPSchIhq7s=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4173.namprd10.prod.outlook.com (2603:10b6:208:1d1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 09:49:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 09:49:40 +0000
Message-ID: <b60e39ce-04bf-4ff9-8879-d9e0cf5d84bd@oracle.com>
Date: Thu, 21 Dec 2023 09:49:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] block atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ming.lei@redhat.com, jaswin@linux.ibm.com, bvanassche@acm.org
References: <20231212110844.19698-1-john.g.garry@oracle.com>
 <20231212163246.GA24594@lst.de>
 <b8b0a9d7-88d2-45a9-877a-ecc5e0f1e645@oracle.com>
 <20231213154409.GA7724@lst.de>
 <c729b03c-b1d1-4458-9983-113f8cd752cd@oracle.com>
 <20231219051456.GB3964019@frogsfrogsfrogs> <20231219052121.GA338@lst.de>
 <76c85021-dd9e-49e3-80e3-25a17c7ca455@oracle.com>
 <20231219151759.GA4468@lst.de>
 <fff50006-ccd2-4944-ba32-84cbb2dbd1f4@oracle.com>
 <20231221065031.GA25778@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231221065031.GA25778@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac26714-acbf-4434-3381-08dc020a26ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uTFVyo4IG3byqH/UHQybWvULvlarbxbxJppZFtxoz8PWgF09tHUM16pyTPpqPJ98oahwC/41Pzn8iE4KhdaTXgz4GcbS56I9mXeVsBeweSKNulGdYhceV4DHNZ0TUnwiLBmICXmG0jAlweogHzM9WNSHWgHPrC7K+g6zW8JCsZhRQnpo6gPyJRHjQNfBkZPgERa2gWee4DzJJaOMbdFNEb3jqla/Yd9NVZ+0bKxAjJ8qEqB60V+JFeVOWLf7hQ8GKuJclhVzwE6wQ2j7u0wOWcLYncjytY/vBOL+jaoIf1WSbndDs/AQeEC8dTVBTxELDoQdympWuHYYPP2/oKNTU76S4bCsNWLsIYwg22vWmq/0NaeLbxJBfnGrS0dp96AYdrWLnRcIjOpaay00tqZwQ49C5QvS1YqgVkic9kB9az+E0F/XfB+nYybtzCSn/WGA5yL/ywHPunXFpwz+N6W9ZUW0TSCsayxkyHGSeEgGVIajoonDK6vPvLdIWluAvpq4DWDoS9k/8fSxFh4OFmu1H0FiNyxD58wIoI2vgUdcRHOAq/7WDJMT2irSCU1nilwN2twCOJpvz8EQVTbU4y05iOQcqOWjZT6mUf0uQvzJqT4vLY8LChEHo9QADxR6Ll5piZmSpYd40/0cQ55nXnNs/Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(2906002)(6666004)(6506007)(31696002)(86362001)(36756003)(6512007)(36916002)(53546011)(478600001)(7416002)(83380400001)(26005)(38100700002)(2616005)(41300700001)(5660300002)(6486002)(66556008)(66476007)(66946007)(31686004)(6916009)(316002)(8676002)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlVGS1FQa0t1VUZUSUNoV09UREZDNGlHOThUbzEzZG50YmJiVUNXSXB6eDZX?=
 =?utf-8?B?dms1SjlWN2FwWm9vKzJaRmhSWFlaSGVPNkhjdzVGYWtYRlFMNlI2Wm1NU0h2?=
 =?utf-8?B?U2FXbElEZlNQb1QwQWNxZzRHcXdkalYrL3FsU2FNektOWXNEN0h6anc2R1d4?=
 =?utf-8?B?aDVQb0xPQXZnc2o2K1JZSXdrUXk0MUJWSGlBOTViYTRDTUZvVzlvNHJnUGRE?=
 =?utf-8?B?M0JyVEJLb1czRUNIeGJGblRpNzBYVE5HZC93T281ZDFjL1dZOEtWTU41ZFBQ?=
 =?utf-8?B?WGp5c2wvOEFFd3dxL2RlQ0tGWVpiaFhPY1BaUS9QSUswd1VVUHdnSU1VcnRM?=
 =?utf-8?B?b0hDUThCWHc3TkdCaU9paER5cWRZVU8vTldkQmdBcUFKaWhVclVjMytoREFF?=
 =?utf-8?B?dytBekR2NXFwVHQxT01YQzV5Rmk4dVZCMzFsRzVUREhiWmlxNWpWQWgrR0hI?=
 =?utf-8?B?QXcxSjY2Yk1Nand2RkVFNzdVY0ZRSXRxOGtXRSsvSFdNN1lYTVE1TDA5WkJu?=
 =?utf-8?B?SFFhRlFjY0R4aUtrNlVHalNMQmZreVpweHpJbXJOcG1UV2cxL1ZQc2tUaWFq?=
 =?utf-8?B?eWVRcWlmdDBHcFlMVlk0V0xFT3lJSmFmbGs3NjlkOWNFR2lzeG9XSWx1QlVh?=
 =?utf-8?B?RUF0WE5HT05ZM25NZGNVaEJTcnNYTTBIbFVnRXRVc0tEaUliMlRwVFF3Y0N0?=
 =?utf-8?B?UE1lSTlxWmRZNzVSWE1IenpPanF0QnBpR3RkRlVHVVhTZFhsdnU2VG1nSTFQ?=
 =?utf-8?B?U3VBZ2lWNWIxWnFmRlVhUnNXZlBEbWFDSjRsS0tDdFR6M3k2UHYxOFVjVTJB?=
 =?utf-8?B?SWhIWW9VTUVXNkRrNnU3eUgwOVQrVjhreW9SQ2w3L1ZYV3VLZ3F4N2ViRU9a?=
 =?utf-8?B?UVRqeG40enZtUHhOUVRSdGdrNW9aN1N5WER5S0FkMi9vbmtpTm1iTm51RVJP?=
 =?utf-8?B?cHZWbzc5dnRieDh4RjJZSU85bmFoM1JvNkdma2pIRVN3UWJVdms1SFczdDVM?=
 =?utf-8?B?MncwU3U3RjJKSVBUNmZLZjB3NEIyMHZLRWJEQUMxWDhvZFRzbEFzRnlTTTc0?=
 =?utf-8?B?SUdTaUxsZGVlMTJMWWJ6VlJUMUlmMVVVcGRqaDJUMGw0dWVsemgzUGllQ3BK?=
 =?utf-8?B?WWpsNWZSbHBZRks3QWx3UE13eHpmRU83VTdrY1QvSTRzL1VZemI5ZmY2dEZ3?=
 =?utf-8?B?YU1adXhpaXJ1cnhySVpwNXkxTU1DcGJNVXh6THBrbG92eURJRllkbkpJUjlh?=
 =?utf-8?B?L3pkc1ZIRHhSUjlYa2x1Y2dRekxNV2ZrRlQ1Q0poU0Q5VW5FWisycEVtWmFN?=
 =?utf-8?B?WUdZV0Z5a093SmxmTVBQb0lhcXRNMXJIci82MUJyWnZ2Uys1STBkaUR2VFZt?=
 =?utf-8?B?QjQ5UERKQWlPT2xXaG1tOTVHek5ZRk9iQjdwMEgvQTJBK2xsY3JMKzExUjQw?=
 =?utf-8?B?NzFoeWhaWEw3VmlOYkJ5OUI1dTNxU0tvZzBBbkdwVlBQQnZXc0NnRC93ejVl?=
 =?utf-8?B?eE16SlFCYUx2OFdSWnQ0cGtPWVYrb3RQMnB6Nm5iVzIzMzZvQmp6N1hiNHh3?=
 =?utf-8?B?R1Ura2Vsdk8xeFV3czJBZDQzUjhXZmVySzBBcWZYMUhnM1htdlBDQ1EyR2hJ?=
 =?utf-8?B?ajB3b3FETFo4MG9vTGFJTjJPaHJtRUEvWnZIelBoMlhkUU9KenlFZ3hPNUgv?=
 =?utf-8?B?MFYzM2JnUlJxV05hODdyRnRsVnVlcTFHNFBtS3V3VUN0Q3pzc0xzaTl4cTg0?=
 =?utf-8?B?bUwvSG9LU1lMVFFsK3Z3OUUxazBtY1NVOEZ4MlJPQWJJN05DQWN5azlGR2hl?=
 =?utf-8?B?OWFhL2FmVjB6RUVqNjBWRy9TSTh2Rm10Q2dyVWhJYUNFSTRJU2MzNEFmcnc3?=
 =?utf-8?B?YnZCT1hoVGFHMXh6SStwdWJjOHFncnNTNFNodmxZbVVGYjRSeEVHU0lkZkFi?=
 =?utf-8?B?S2svN2FRdGNUZWdSZ044ZU1RaGYzM25tWmVUMVVLZkxaT0JYLzloTzhHUXFC?=
 =?utf-8?B?YlBnTFlCVllaaGN6TXRCaEVxTTErbGlFWFBNSFFSYndPb0Mza2dpMi9ra1gx?=
 =?utf-8?B?SHhDVkNsbU8wcmMrdlRqeGU0bXV5bytrdVhBQTM4TFhrdnQwR3NBZHBlS0tl?=
 =?utf-8?B?TnJLQkRQeUxOd1hCRDBsbGRGNG1ieVgyejNnVmp6cE81dm5GaFk5QVBHNUgw?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ow3Kmq0itvG7h0J5BfhilxSy1dpQenIMnBEGPsv5yKcPVKTWpn/uDiCNPPScC6bknXpTrkNkelcKRpTyDcW155iNf9906/DDxYWlo0TmWSy21BQVs4cSsIuxFQ/CCPKMK3v9dR+WOsU7pUPikboJ14hxuUgzyr5llRBPxcMQFovTqy9NCRsjmfuUAfvzFmCBWSYWwb5+E7+xBJIFDR8J4Xw/a9cIO/U87ame/pb01kzRsRJ3pW68fqUi3KDTfEs9wjCjUWO3n0lhrO+8nOZgS+xO35idejufNmnf+/EyU/7W4bDAyhssm92aYZU7h1tOssnuq9oGG4EMbZiSiarvqg+WfdvEbjcqVrkeDf87UNuvGBLSaVIYvCP+KrVLLDmo/f0txOz3tmLiK1hC4QB6iX+sSOMTqHiGfmGDheop9NYzHoJv1Vqf32yu8mgfFpAlUTpvyVpQ9w2WU7micyaBmpc6aSv3/9fUmm/yAP/BAIlChPsHdrzZ8uRvLM3MvHUI3ojKETLDRwVrjArbSOgNaAAbqeqHhvv/iHTb8nVxlkj57qSzfrz47sccGvMz+8xAtrdUpn+CAUwZcs9Y+ofu70kwqQfa1581N7vmMRzLy6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac26714-acbf-4434-3381-08dc020a26ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 09:49:40.3927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahgBWTO2+HNeWRaO3Pl6TDUFnURzBiPgwhCF0jLpIchxjy/AfWPAf3X9rX6uTYSZf5vCUBiiCInX4nT3Tifg7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-21_04,2023-12-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312210072
X-Proofpoint-GUID: QVICMD2iccCAiUtrI2VB04jtiWqEpfZy
X-Proofpoint-ORIG-GUID: QVICMD2iccCAiUtrI2VB04jtiWqEpfZy

On 21/12/2023 06:50, Christoph Hellwig wrote:
> On Tue, Dec 19, 2023 at 04:53:27PM +0000, John Garry wrote:
>> On 19/12/2023 15:17, Christoph Hellwig wrote:
>>> On Tue, Dec 19, 2023 at 12:41:37PM +0000, John Garry wrote:
>>>> How about something based on fcntl, like below? We will prob also require
>>>> some per-FS flag for enabling atomic writes without HW support. That flag
>>>> might be also useful for XFS for differentiating forcealign for atomic
>>>> writes with just forcealign.
>>> I would have just exposed it through a user visible flag instead of
>>> adding yet another ioctl/fcntl opcode and yet another method.
>>>
>>
>> Any specific type of flag?
>>
>> I would suggest a file attribute which we can set via chattr, but that is
>> still using an ioctl and would require a new inode flag; but at least there
>> is standard userspace support.
> 
> I'd be fine with that, but we're kinda running out of flag there.

Yeah, in looking at e2fsprogs they are all used.

> That's why I suggested the FS_XFLAG_ instead, which basically works
> the same.
> 

ok, fine, we can try that out.

On another topic, maybe you can advise..

I noticed the NVMe patch to stop always setting virt boundary (thanks), 
but I am struggling for the wording for iovecs rules. I'd like to reuse 
iov_iter_is_aligned() to enforce any such rule.

I am thinking:
- ubuf / iovecs need to be PAGE-aligned
- each iovec needs to be length of multiple of PAGE_SIZE

But that does not work for total length < PAGE_SIZE.

So then we could have:
- ubuf / iovecs need to be PAGE-aligned
- each iovec needs to be length of multiple of atomic_write_unit_min. If 
total length > PAGE_SIZE, each iovec also needs to be a multiple of 
PAGE_SIZE.

I'd rather something simpler. Maybe it's ok.

Thanks,
John


