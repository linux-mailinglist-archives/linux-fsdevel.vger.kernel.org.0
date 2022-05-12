Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E31524636
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 08:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350597AbiELG4k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 02:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350641AbiELG40 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 02:56:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E321836F;
        Wed, 11 May 2022 23:56:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C2Fq2V011683;
        Thu, 12 May 2022 06:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ctzEqjvt+xdIwBCVlHQyJeRJAtI79jRoo5zpaafxBL4=;
 b=ZP9mkP8HFEBViRfGB0bg82myK0RvbcaIZCyvUxAm0zoJ5KsW80KONnPD0oiFWhsFrUFP
 8YYRoXs1QrVhtfu+rTvuipkjWLlsQ2RZJCLsfv0AxOvGLMqGX56RbIgB54KmXdWGZV0i
 HZ+euQuWAEcGTe+bwk0ei8UWDH9BAWVI4Dro6YMSx5MbjS1MOwwp2ac84LHHga4hajts
 NFOEP7r8Az1GkfFGm+MRS7k3QBhOmj0Pb6782ZZNEzQ7SUQj66b/4jFvW2QSBoH7zJXk
 OXBVFqn+Yi2xhfktaX4YIRBf7Q84769zLBOtH+VqQO8ZeYqvG/bEH7paK4T3+bP+IIwI dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fwgcsuwrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:56:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24C6tgWw021116;
        Thu, 12 May 2022 06:56:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fwf7bdyxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 06:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwU4GGFlknviR4JyfuViX7YWqzCy7R0PrPi9ZMafB9C6yKG2wHAS2CGtaexqDheNp4GEKUW7WVU11Ui2e6CnqcMR7yaKvn+mBbH/FQumf+IvJy3K9y/iwgqPImbOVpJMtxRYxtBf822cia2cRBvd+fIbCF9JVT366DEMHFCvuQNDEDiikWQyZ+wOi4bXRBPpMQ5pON4mbc4d/pAm5AcnCv0iB/am/GFYSNG6f2+mYzRgCy4BgRVUvL7heKU5XtUavVBfL1xER8OKui+I4wJY3DqE41g15JYOFCmTHWD1OyV4IWsqxZUEcVjS8w8zvYlwOCUopLH2gPykE0js2IPusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctzEqjvt+xdIwBCVlHQyJeRJAtI79jRoo5zpaafxBL4=;
 b=Zn8J20fxhcI494/RffpWtQ7oPXfr9Y63vb3kcQGRrnWv8UgyzFbY+HKrqyUSHdjNsY3j0/TSfJHr4/l16G/9ZMhGmacyCYbvm1k8w6zDjsxo9gB5418Eo7yKmxF3ocg2pvasmIGEpMuUx2djXwtbQ9RddiAdXAY7svOphorXPrP9Bp0h9HmvT7lVIarrc2S974FwHoHd1ImVUv/kJhiw7qp0oYoTF0wqQhJnCBvhlmlg1GVmyyVQst3GXmxdySHsjnx5kfVewqMUd2vXxfTU2a3FH2mytyku+DjSRMFFG9XZ28nayg4TZIU4uRTVpC5T3o9VSSbQWAKjpJTBfLEvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctzEqjvt+xdIwBCVlHQyJeRJAtI79jRoo5zpaafxBL4=;
 b=DM4J2vJ1iOgnAuN2tXr6bcFQZ8U6qYJ4PSu4y61mMnc8OsJHE4T09r72qUWIyhtcnCFHkDb+yUjEdNETMVhQYJOWkWawmXDL8ZXyx5e/AqbAo9ZGuR/gHVax3ETGQ18Be/X1A232NkD4hY88XCndiQV+/zwZFBv7LxSSQD7s9Wc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5058.namprd10.prod.outlook.com (2603:10b6:208:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Thu, 12 May
 2022 06:56:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%8]) with mapi id 15.20.5227.018; Thu, 12 May 2022
 06:56:10 +0000
Message-ID: <dcab2ed0-d48f-e987-47fa-2fd1fc2dba08@oracle.com>
Date:   Thu, 12 May 2022 12:25:57 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: reduce memory allocation in the btrfs direct I/O path v2
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20220505201115.937837-1-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220505201115.937837-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::7) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 054306bb-70c8-4017-4a0b-08da33e47ecf
X-MS-TrafficTypeDiagnostic: BLAPR10MB5058:EE_
X-Microsoft-Antispam-PRVS: <BLAPR10MB5058018A18AE1A08EC787A3CE5CB9@BLAPR10MB5058.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKwLiroAs4yuPgj97OnzBUz5scq2XXLYUrW9jJmpsI3uN2pnF4TFza4EiGCTNFpd3Mk8RtHlL2TVK3Q2SfrTqsfwyUCZqFvUCbYyFHO4xhyMbkI2wp9Q7Z9HgoICls5Nq1shL36vQX9qJzIq8E9PykBGuGuhfsdu8GhxaZ+F6aCnQUuEWNdeHFXw0EofoKmtCO3DHqZjlMMgD2QVL6XBOl/7V8jVEfGaINYW1GuoGSKcUr7RH87mrC6Oj7R4N19EYGVs1rhjJorvJ0J8dQB9ajSVk78mAeYBPgj/D3LpnPb2QxMmr2xcFV78x3CV9z4uUyA+DvL40KIoGPWypt9nru1Vug5e2sF5uML3idfJ5aJQ+xPC9aOrKVtQmZG0UrjKZmKp2P22OafQhluzLqSqVct9SxWVMgCDf4sLurU08S8+iRHpVnuler1KjxcRML47VrzFysrYvR+ewZsY1XT8rq5HaMWwsmcxS2GlxV5JMJLcNWkRovtITnBI6SBxN/qVu5FEUxFFYVIfd4ZOydmZwGm7V2MnbqjNJSOdC/s9G2G49x/1dS21NUzcuV3hfGYmL7eQD2M+Vig7lKcMqJwAHgOQgke7OuAnqnOUOFbDUi+AfY5+3yAXp8C5cNMTl0h01cuXdkim9XAg7TemrKUSmCwn50XW64UQ1mO2xFXC5KXBeccIfRPcFdwFREVHUM7/kZPLT33+vlnxbtg/D/sATyiLaA/dYwjy3yjdBvn4Ask=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(66476007)(2906002)(66556008)(6512007)(36756003)(6486002)(31686004)(508600001)(6666004)(31696002)(86362001)(316002)(8676002)(4326008)(44832011)(6506007)(53546011)(38100700002)(83380400001)(5660300002)(8936002)(186003)(2616005)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZnaExodTYwS1Qzcm1NQTBuL1FNT0N4Slluamw1OWxicHBRUGpoWTlyeEY3?=
 =?utf-8?B?clJxREt4ODNrVVVnN2d5YlFWcGNpOGpPb0pKMFVsRlhYeWhsZVpNaHJLTEt2?=
 =?utf-8?B?UGJVL0lyd3VwdTVYcnpBbWhrVjl4Umw1Y1gwaEk2UjRoTVdrQzQ1dlE4ZWEr?=
 =?utf-8?B?TEZRT2c2ZkJiRENpVWNOUVg1R3dlelozdG9ydDRJL1cwQkhuenJJbWphbHhw?=
 =?utf-8?B?ME9Ma2dWbmpMN3dVbE5DOTQwRmV3Q0dNREl3ZnNQRzFwV1BJSDJhV1FaTTha?=
 =?utf-8?B?SGdIZlc5VDFJRDFIZVRvUlJiZmdJZzBvU3UrKzh0ekJkeW83MVZMTFRSZFdy?=
 =?utf-8?B?TXZreGM4M3Y4SWN5SXY1c1E5VW9NWEQ1cEdoSVFxcUd4VTUwNHJCcTNVMkVz?=
 =?utf-8?B?emdnMEI0Y3B5MGFSVFZ6Y1hLZm13M3V5NUFRV0o1Z2FDN1AyQjlHTTBxYVZh?=
 =?utf-8?B?YlllUUFRZTZiZzZvU01SeWxLQ2tUeFc4Wk1haXRkVVprOGNET3BXVHBXWEJF?=
 =?utf-8?B?UlhnNC9FWUNEWVoxc080WVRzRVVpL3Jtd0lXMUFCUVRFd2pRZDNJMzh2R21O?=
 =?utf-8?B?N2U0TFBxSytndlIzY0dWcm11YXdYajdmZ2J3Q2dwSUx6RmRGaFBiTVhmcjhs?=
 =?utf-8?B?Wmw2RGFTemFvRzIxemVuYkhMMUJMV3lwQUNSdDdZYzNvYXZLdHpacWU2ZE1R?=
 =?utf-8?B?bytQMnNTWElrQjNTMGluSlJ4YW9RSjlMZC9ZUW9CUDNzbVJMSVBYMXlnY29U?=
 =?utf-8?B?N25tSGNuQXUyNktxeHFkQkUxR3ZSOWovKzA2KzJCZ3h4UkhvTTFPQzdMaUJv?=
 =?utf-8?B?VEZidmV0cGw5L05qUnZkblFYMlZQS0ZxS090Uno0alk2QXlDSTBtYkg4RllS?=
 =?utf-8?B?dFNQOXdBU2NuWkNpQWlDbFEyTW9nTGE3UnZHMGFPUmJsNXNRMXBnaWNCUkdy?=
 =?utf-8?B?ZXM4M01NSlord1FsSDFIR3N1MGtIbHVUaWNiWnBocVpFdWVGNDRhdzVGUlBF?=
 =?utf-8?B?UW5Bd1VTWWdtaFRjV3NYdWZ1UDdRaHF1dllnN08vd2F5ZnRuUU9DT0hqYk5U?=
 =?utf-8?B?U1NQODJuZGQ5YzNZL0l1Z2RObVVIcjljYzYyZmFDT1V1MWx2NFpIakdNK0Qw?=
 =?utf-8?B?SFMrRHFvRE9MM0psWlgyeGZTbVVNYm81bVRTV3k4NnFrcUd2NDd5a1gzRWJ1?=
 =?utf-8?B?THFFSTBpODlzbGs0RVQrenNPd25xa0l6TnFiR2JrMjBxcGZ4S0RkZTJzamVB?=
 =?utf-8?B?NldQYkFaTzNYY1YrMEZCWCtDY0dycTRFYTRlTGVkVjV1YWlveTFQK1FRN2gy?=
 =?utf-8?B?MDlROUo3b045bk5uYXFxWmFlTVluWGsxOHA3Z2lpcUNRZHpFSjBpL1ZyN2xz?=
 =?utf-8?B?S3l6Z2dpSVVubERVcSt6RkhQeTYza0prRjV5c0dhWitlcXB6alBYYk9HTTFK?=
 =?utf-8?B?M2EvSXpDWUJtMUVqUW4wQVNnNllGSjNBWklkbGtPWHcybGR1TU5aQVg3aXk0?=
 =?utf-8?B?QUlHbkRPbXlXVWt1enE3WFpMMTlBdVdEN3AvZEZHQkg0WEpqNDZ2czJLazRP?=
 =?utf-8?B?bVdYcnNCZGhhTm4yeFBFb2UydTJGV2VDV2F0SEtjSm5wdnZNWnB4SUdmMXYr?=
 =?utf-8?B?cGVuZU9LditNcERza3l4SUJMUERVVmxWZVVmdVo4WERHTkFZK2xoS0JlV0Fq?=
 =?utf-8?B?eDMwb1NLUCs0TkpQZHNQRlpiRkl3WTFOamZPTmcvRm0vcWFwN09vZmMycGFv?=
 =?utf-8?B?UnY2VjdkdmZmVVB0eEZGdTBobHVHRHl0cGpaRUIrd1NoWmlSU2tvazRGdDFI?=
 =?utf-8?B?VDNoN3RpUk5rb3V0Z3d5bmNYKzBmd1EwZjBSZDdTSnptRm1qTXZjQ1ltS1M0?=
 =?utf-8?B?MXZtT2FyQ3VyWUVaNGNhZTRaSWZMSHloV0I0Nzd2bDl6RnRyM1IwaFZ2Nldm?=
 =?utf-8?B?c2VNaDZFUWE2cnZZN2VjUFh1WjBHa2Y0MnVCdUo0cks3LzBxTHJNTXVlOXRI?=
 =?utf-8?B?ek1iOS9INXBLUkE4cnczaTdPVndxdVNsaGVKeDlBTEtYdkhOanBaNEZkTFJQ?=
 =?utf-8?B?OGNzbG50RnNKaHl4NFZ0UURzN2RNV0M1cWdXOXBYZDlKS2w2ejA3YllGekpJ?=
 =?utf-8?B?MXB0VVZOenVWc1ZEYzdFOWVYYVk2NWZBVWp4WDlWNFJrVmlRNDZxOU03QllW?=
 =?utf-8?B?MG5kaS85YTdqWTN4eHliSHp3RUJ2bVlGVGxQTUkxRWVsdFAxVjZoWXRJdVVy?=
 =?utf-8?B?c01aZ2cxZ0NaaHR2L3hLWlQ4TFhCOTVyV0tna3NSaDR6djJsaWlQVWpPNVAx?=
 =?utf-8?B?YnhRL3F0N0RYZ1VsdGZjTTZsT0ZSckFNNytUYVpLbWxMZ1lzck5OVFBrS2ZK?=
 =?utf-8?Q?tk9goqs0cHgSFDUM2MyFTXAjucL8KNi/yvPU0LcjqBSr/?=
X-MS-Exchange-AntiSpam-MessageData-1: szcNv3LY/rTk/owJ8vwKziQw8QZPu0S8vL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 054306bb-70c8-4017-4a0b-08da33e47ecf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 06:56:10.2857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYBRjwIzX/bjgQqJmtz0u4w6fsNHgZiaR6cP0/F2CCe+tX3u4pkzHEWDqOfN2CWwi9oIjtSPVN/+8pqIMyOKEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5058
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-12_01:2022-05-12,2022-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=517
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120031
X-Proofpoint-GUID: wZ8mibHnAhTeps5OJQTd9PVxgQUXKIhj
X-Proofpoint-ORIG-GUID: wZ8mibHnAhTeps5OJQTd9PVxgQUXKIhj
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/22 01:41, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds two minor improvements to iomap that allow btrfs
> to avoid a memory allocation per read/write system call and another
> one per submitted bio.  I also have at last two other pending uses
> for the iomap functionality later on, so they are not really btrfs
> specific either.
> 
> Changes since v1:
>   - pass the private data direct to iomap_dio_rw instead of through the
>     iocb
>   - better document the bio_set in iomap_dio_ops
>   - split a patch into three
>   - use kcalloc to allocate the checksums
> 
> Diffstat:
>   fs/btrfs/btrfs_inode.h |   25 --------
>   fs/btrfs/ctree.h       |    6 -
>   fs/btrfs/file.c        |    6 -
>   fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
>   fs/erofs/data.c        |    2
>   fs/ext4/file.c         |    4 -
>   fs/f2fs/file.c         |    4 -
>   fs/gfs2/file.c         |    4 -
>   fs/iomap/direct-io.c   |   26 ++++++--
>   fs/xfs/xfs_file.c      |    6 -
>   fs/zonefs/super.c      |    4 -
>   include/linux/iomap.h  |   16 ++++-
>   12 files changed, 123 insertions(+), 132 deletions(-)

This patch got me curious a couple of days back while I was tracing
a dio read performance issue on nvme. I am sharing the results as below.
[1]. There is no performance difference. Thx.


[1]
Before:
  4971MB/s 4474GB iocounts: nvme3n1 545220968 nvme0n1 547007640 
single_d2/5.18.0-rc5+_misc-next_1

After:
  4968MB/s 4471GB iocounts: nvme3n1 544207371 nvme1n1 547458037 
single_d2/5.18.0-rc5+_dio_cleanup_hch_1

  readstat /btrfs fio --eta=auto --output=$CMDLOG \
--name fiotest --directory=/btrfs --rw=randread \
--bs=4k --size=4G --ioengine=libaio --iodepth=16 --direct=1 \
--time_based=1 --runtime=900 --randrepeat=1 --gtod_reduce=1 \
--group_reporting=1 --numjobs=64
