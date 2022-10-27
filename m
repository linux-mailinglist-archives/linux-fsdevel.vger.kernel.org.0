Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3E9610569
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 00:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiJ0WNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiJ0WNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:13:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF03A50FF;
        Thu, 27 Oct 2022 15:13:03 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKQN8u001416;
        Thu, 27 Oct 2022 22:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Og76WYsPH9A/yY0HEwyA8AgLlETuZZi+rdG8UVhdZ04=;
 b=crJ+7u896fh/I63ghjkqRkk55JT3fslYmVEA0LzAUv91H1t3dDc9djV/4tKLdowUPqsa
 /hlzNsloIxLSMcpGGlf7UW+utCl/kTQNh+CXbwmY9CiGwynX5tnRbHI+Pviiwtvkdhbb
 ttbSB9oBdm7/AP7Ny9Bge0PNhi34jKA+BHyuMxtE7Lk+MLLS7ulKhhskP4GzA1BDNgrz
 BZ9hJGlp/8N7pmWC+V1YFzvG2otZuEpx5kjd0ZCdqJ39Qyx9fQVagGMt8s28Tk4clzZN
 Eh4LKd56eqTVUGMiiAd3XF4aWhM2Lupv84v36voWs+lC4P40Dl6Ep2lgRNosUmPHBNmj og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrujcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:12:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RKXkVw006533;
        Thu, 27 Oct 2022 22:12:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaghegs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 22:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMEKK4Jf0WxdtW4/Ujzs6d1N9HzA+1kLhpa3Cz7W0xP72H9Tc3qdi/bJ5/H0pUItomarRtvf8OHU0RQEF1IoCR7fYaVkMHzJ19PT3tJDeTNvD/YmtjpN1Tx1dDOpZUA7L3y8xQEjgdNHVzoCHJ3/bD7+us2jQF3IQixF5Ek1DOq5Js3pGm1x90QT42OhesCGMcP7lOZqbZjc4+/ujP79e2SGnlR6Jy42GiqJpiEe7ugyiRTMz1ELf5/554LytAkZu9T7Tg8m2kTy2h5AMklgQqJDX0j5VnaekNK7tg/2/5DhwbvifpgyO5w6Icb4pIsRmc9rBKKcqG/NK8brankUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Og76WYsPH9A/yY0HEwyA8AgLlETuZZi+rdG8UVhdZ04=;
 b=JYbEb4Ur0ghSOfOMJcKEesR95cdSaPPKkzfEmRefVmRBseNJv6caYNsqFwq6J7HBkQP/wKbcctlmSgEr0LKqHBBQfJM6gnDkyFYhTvT5/l83fKPX6XA+dVDSqMkwyapvwA+N77SNk1MPEDQEpvX77omYobxxFD7Sj6HWhwl3tG7DnyYzAJJiqehEss32vqIBWUCBKts93LmLe6wEW3HLJYTw/6hF4ay2emWGSfjra3ZgjSHw0xTBsAdJuNDBxot8zVN/h8JY8aDcJjZFuhxOj+e7vGIM6SJbxIitY2GgEvPQ8c/bzdVrwwytrV0DKeValxbqmh+itRdnm7AHs4Z45Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Og76WYsPH9A/yY0HEwyA8AgLlETuZZi+rdG8UVhdZ04=;
 b=AKH94qfijWur0WrrTosltggsOStOPhF1YeLCimNWm2Kjs0HJ/0JQDzRl8f4QHZL8O1k2YVxorj8Vh2BCJl0WomCf4vEdVQ2ZtkCWOwhVE8kXXO8yqNK0n3wN8tV7TAKMyQmw4cOtoNlIrdRI6XC2bGFJaZySv8cuiwuMQ3QeRc4=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB5379.namprd10.prod.outlook.com (2603:10b6:208:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 22:12:52 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%9]) with mapi id 15.20.5769.015; Thu, 27 Oct 2022
 22:12:51 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsnotify: allow sleepable child flag update
In-Reply-To: <Y1pE/MdXBB9swEZ/@yujie-X299>
References: <20221018041233.376977-3-stephen.s.brennan@oracle.com>
 <202210271500.731e3808-yujie.liu@intel.com> <Y1pE/MdXBB9swEZ/@yujie-X299>
Date:   Thu, 27 Oct 2022 15:12:41 -0700
Message-ID: <87a65ghq5i.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9P223CA0012.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::17) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BLAPR10MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c1b865a-020f-4e1a-f26b-08dab86863d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: svPuK9DCNneew8z5Sskqyk01qpYljq71QemZVlSeRvV4LxKPmcmrR1zZtbqQf9LElVufOMrNPEsJOqJNuhUI2pbWZSPtP4fnXudnGPSup6gJB3wC15MuLzivD0qcLr+9fy/wBAs5BkuqbiCG8AkvCxzoFhzmvadl3C8T9PmEyxfu7b263xOT0H3S6aHno2ShI1nkoD3onXv/HrpKZGpkM6XGaMeXGDqcl3A7qgCq8P3bgCB0u6mp4Mr8gbbG4FWg9m5NbjBVyT11WijauvYZHgTr2/6820F+rYSuhU62UxaBH4daNlJH3fdWpecvTZCDU3s+xI3PeBnfILfw7eVnoXq7kaJrdH9m1IDIWr9AeOdar4haw5zqOKleg7nl4ZsCGRXZwA/6sr5qLoJ10mb6gnN3ogi3BCc7wfpyWhG1PdJlB3LDsr4p7Tg6Ug3J0gme+wubZyEfS6m87gITVcraOiz080Vc7EkqwQdyufCRvVsUWSP20oFikq0C7OcH5Ku/zTSK8woX6c0l9lGUDUdBhcwnyXnogD0EB5mHxA76LpMsRmvDKhiz/weENzF0lCIgR+Kkw0O1unvZQUY/XPju0ZXdGK/mo7VwTXQSlaRZ+f4St3Db1hEAzIxya9vki3qaLUTqBa+hkDzwz0zMc6KD9qCp01VwwesdmDMr0bW8KXYcBwxozwLRxIdylZr7G/CLKkwVmg0ly6ettv2Ds7bf1HriVtDLoXfM06F5PqOyNZEgaPxxqN6oeUVGPN48wdJZU32naAvxzeemLLKyk6vu/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(966005)(54906003)(6486002)(5660300002)(38100700002)(478600001)(66946007)(41300700001)(66556008)(86362001)(8936002)(4326008)(66476007)(8676002)(36756003)(6916009)(316002)(2616005)(2906002)(186003)(15650500001)(6506007)(6512007)(83380400001)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09Lia3LrmuRir9S6r0BRjMskVzLKJWC9y8EEoES8QcS7u7NYWkIIqE3IWgc9?=
 =?us-ascii?Q?bnvh+Ud98zr5n2vhSiMWqnK03PRx4SkSggPj7UbzrWf3RtdyEoZUQ0uQN4PG?=
 =?us-ascii?Q?bquYBpyWPD55Dk6LgqXdFRaAxMGiPLRBknOoy7yTvE86DXGKoVZs8vaZzCgl?=
 =?us-ascii?Q?QG55IWjI5+P8JESGqw9sbysxY12M2QSQFZ3z/O1KcwVpY8zwOxW661QyEgH+?=
 =?us-ascii?Q?oeIZPj0f8+HJugK88e3jUqhex2m+yQst77bVW1FBn7OPb8uvdobd0H8XUR5R?=
 =?us-ascii?Q?lt55qWIVRGtB/05l+0qdroBKk5McBkSwrUfPXQILLfJvB5OXyclHafaITuVM?=
 =?us-ascii?Q?Gk5kne8F81Noj+0kAzQFaz6R6mjf+8likGyCPWwa8P3+nQLDeJxty32rfkaA?=
 =?us-ascii?Q?+AlivCHBy/eppoZX52yBnbCWqDDetrfznlq0Xu7Z9RZN1Wdi4qkPEdlE2nY/?=
 =?us-ascii?Q?qM2f/GxAgLWDWTLrq5zJ44DRa6Irc401hKiFz4pNEMfMXArl6gYxef/WniEz?=
 =?us-ascii?Q?FhRuSBvPover08Q3WVF9IvZxVr/2+tHg3rxxAsB/g5rtj16ALq+29xXCZ62M?=
 =?us-ascii?Q?775oALiB74Uyf0E0OBzeKd0AVzv5hqmmdlaPxespBk7D0sHW+U1XWI1zoLfA?=
 =?us-ascii?Q?qVjoVDIMSDHPRkwJdzloWKXIRPjcdUALiNQ8aweHVsT/2+0JIUuWJ0AZj451?=
 =?us-ascii?Q?qNDoNEpXbCBAVTPdk3ZXyJKXIWNZxQ1LlhV8+8ICW2sgqf/hxVOUq2TIiXI/?=
 =?us-ascii?Q?+3hnyZLFSJnw09cFXvYkG/jVQyH+PHuU/1vUoo977+ft+WVczjevjZljnXHW?=
 =?us-ascii?Q?gVBO3V8kzNOpojGXBMEyAicHpPcyKWq9oshhYJejzIYg3UhITpUPiRYs+LVB?=
 =?us-ascii?Q?yORZphPYa3RJ3lrk1WXZV57ky6yGa2l9LQOoCT8MKw+NuYp7uamsZQgBIs/u?=
 =?us-ascii?Q?C/5zLcscsPxbMcMVYxd5+xV0JKf2S+nbIz950QyIAIQZIQwrg0MziMEW9hQ0?=
 =?us-ascii?Q?Jbfpg6YGh2z6QeqWRKazYloyXAYMuLXv/KAoMGpAcOCyZ5bFSt4ReQdkj19J?=
 =?us-ascii?Q?hwhvp3jqqtYtpcRUW+lvc14H1T71umYtihqRFe9rXziMgzmkXx2RLLi3B32e?=
 =?us-ascii?Q?xFhcqFoNV5cLAo//XdVMEV3rCB81Tue3Mb5aimDhe1sOU+FcUqVepBQq8Rdc?=
 =?us-ascii?Q?zW9MCh1VAZpCdXhYwIR2Q5z5M+UEWznitcrQi8XeOGnBmeN6ETckuWtiJNp3?=
 =?us-ascii?Q?AogMeSManAnV4bv1HB9xwaNx7HFv6SrGdRW0iETrqXH7Eq4g7FN8+N9DDgY/?=
 =?us-ascii?Q?PGkqz25YOiKH5UB35BI0dBBjEDvNc8rAd8zhPq5EmAh/54LSG9dzNkDBMGbh?=
 =?us-ascii?Q?CVvifeiIkr5UIr+vrdHrsYVOyA7UY9x7dqO2Fu22FBRfP3EzMZqAjrP7u1c5?=
 =?us-ascii?Q?ukRzydG9iSOfcVuajY/VX1qmgxNG3YSIONPlvM7h7nfHZ4wJ9D64/NAOvfhk?=
 =?us-ascii?Q?pZZNDQKZj6gtP8EbUgqNisqCb4z7clIT84svQgJ55OayJFkYDougZbwqShCI?=
 =?us-ascii?Q?0dXS03HIt2Pp++Ym82uxQo61Ro9kC4nGrehm06UBwJHYDOk1PJ44AndaRV1Q?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c1b865a-020f-4e1a-f26b-08dab86863d1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 22:12:51.8565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dArlA8vg256GJb9szVd0uMHDOLhIYP3VLbNQExs51g/J8G+7HaWHznDUpxfWpcbzmxx/KuaNj6cUISCcABNoapT/kqjkbNNM+bJthVOLMFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5379
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270125
X-Proofpoint-ORIG-GUID: MBSqgzy2geslFhVNMPzv1FvfDIhZMkb9
X-Proofpoint-GUID: MBSqgzy2geslFhVNMPzv1FvfDIhZMkb9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yujie Liu <yujie.liu@intel.com> writes:
> On Thu, Oct 27, 2022 at 03:50:17PM +0800, kernel test robot wrote:
>> Greeting,
>> 
>> FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with clang-14):
>> 
>> commit: bed2685d9557ff9a7705f4172651a138e5f705af ("[PATCH 2/2] fsnotify: allow sleepable child flag update")
>> url: https://github.com/intel-lab-lkp/linux/commits/Stephen-Brennan/fsnotify-Protect-i_fsnotify_mask-and-child-flags-with-inode-rwsem/20221018-131326
>> base: https://git.kernel.org/cgit/linux/kernel/git/jack/linux-fs.git fsnotify
>> patch link: https://lore.kernel.org/linux-fsdevel/20221018041233.376977-3-stephen.s.brennan@oracle.com
>> patch subject: [PATCH 2/2] fsnotify: allow sleepable child flag update
>> 
>> in testcase: boot
>> 
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>> 
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>
> Sorry, this report is for the v1 patch which seems to be obsolete now.
> Please kindly check the details in report, if the issue has already been
> fixed in v2, please ignore this report. Thanks.

Thanks for the message, I'm looking deeper into it now. If it were to
happen on the v1, it may very well occur on v2.

Thanks,
Stephen
