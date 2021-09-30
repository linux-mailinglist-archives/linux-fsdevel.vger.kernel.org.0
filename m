Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DB241E0A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbhI3SI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 14:08:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26216 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353022AbhI3SI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:08:57 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18UHePVd011116;
        Thu, 30 Sep 2021 18:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cX7mcfrCVk0a6CXX+fNmT2/Mp+C05IQb4UqyoZgZ6gc=;
 b=I7I9G8DL7z7+VBoENLFfqt2Ytim3QJtS90Ocq5C9Xx1eATGImDZTr4l0dNM9KEhGVesa
 +qh+DoUhhDuofGzabU/jzp204uwbkr+udBpwxljEBlZVgUqpKGlpsS5NmK369bQyUHWq
 X1oVOkukt+Db9dZLSIZJXm+ZPlfMSwDiW+1jkMiLN56IyKlnMJ14jsLZmHhKA4BhJiDq
 uVaKe/KrgFp+dL+R0Oz/PkPtKhfRWvTajlX6Hw5CmuNV10O3x/lERmZvSUtwKpZSj/AV
 nsS6TCddr/0RE7HIbJg7xnlUZshDa8uJt0b8xSpA6pMb2KGiIMVoI6HfSH4iyKxSxOfX 4A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdds824xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 18:06:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18UI1ECi141867;
        Thu, 30 Sep 2021 18:05:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3030.oracle.com with ESMTP id 3bd5wbh0a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 18:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IukaMdykWNmcKY0t8IMIxL/J8+PrgJ8y/nLl1QU1Hkit6HrWzwSwpMP5Sl4lMcM7GRwx5ds5uvlx96vfEbzTsDhikZGERfIZ+jlRfjfcW2LUUkUEHU5ymEk6GeCXW65AIONeVPqGVVp/LrGWnHstUKoM8G4+nQ/xWshQJXiNLj5nZw4+vKdTEAKo+6fkzceVCsDV6ayHmIM13OBLnn+9w+Jzrsm134tPZegn7eH9qcGnaa7UJU87+egprE9TRUBm1YWdC0GM/aWk5NE2pfzFYgM4UkMGX8ADr+eIX8crHfKC8P/aj1PuQwJv04wWmCEa0fhwp+VJSwvutZOQWE17oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=cX7mcfrCVk0a6CXX+fNmT2/Mp+C05IQb4UqyoZgZ6gc=;
 b=ZiOWFznyPqef6ON5nNO3ur/xG1f2kGUDu4idtSGbcTCL5niL8WVEdPZ8z0xknri3vYiS1YNmfe1Z9CfFKGRtVcKGpNvcJCrcD8Cga/Zo5W97wG7QB5b7LbIWuiYJLeNtRADh92/CFEDJHsVOC8p+XmzbrYWdSGvomQGM6XkBqs65NRszbVlgJvSrvjRl77qJs9gOempV1YzjCBviHQ/EiRxVCzrBPpL0DcIu+Mi+9XopYBIurZxqeS0RIKGeg6YCt7HFQm6vLb6vZTld6F4eSbUvqyUnx+xOQo7t693jCL1yuUFDClKG1FFs6+JvUJ5fHsVkequ+bY0Fffkrl/O5ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX7mcfrCVk0a6CXX+fNmT2/Mp+C05IQb4UqyoZgZ6gc=;
 b=BtSr5tlkG/nEQsYwejQPwiQbTO3hKcVb4j5Mg2EL4wYh2WRWng0V08JlmRwrJcXJccC1kvwojVmZK7Tt3WBdVKci1bN67Klegl+vVi96vig6cP5eOFnenbxhG+bSfpsnZ8euMJfn1gp0o6uAclrBcO/EilFjnpLbsm58x0fKVbs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Thu, 30 Sep
 2021 18:05:27 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%8]) with mapi id 15.20.4566.014; Thu, 30 Sep 2021
 18:05:27 +0000
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        =?UTF-8?Q?Michael_Wei=c3=9f?= <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210923233105.4045080-1-keescook@chromium.org>
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
Message-ID: <c283c978-2563-06b9-4c21-59bedceda9ea@oracle.com>
Date:   Thu, 30 Sep 2021 11:05:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210923233105.4045080-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::25) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
Received: from stepbren-lnx.us.oracle.com (148.87.23.8) by BYAPR07CA0012.namprd07.prod.outlook.com (2603:10b6:a02:bc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 18:05:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d4da11a-f64d-40b6-c77c-08d9843ce1a0
X-MS-TrafficTypeDiagnostic: CH2PR10MB4261:
X-Microsoft-Antispam-PRVS: <CH2PR10MB426176F37829D46682CF8433DBAA9@CH2PR10MB4261.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TX7hE7pLINfSsy/a5oyMv4TUVj9SRIRDlRE0ZgVjeRpUIPrs/2zKQw1KTcXDsmfUPCeBu4tHgXWy+JD9/f41ymrVoDLY5nEtM4H5zZN82Bz4/d5ZCsvfc+TOzmCbHaCQnQVWmmNUWB2qXdLcdyCiyT6Wdg4TpFQHUv0Iq5/jkTahrKiuOlvRsxeR7AzR2PrhLV/ct+c1Jc7xGJyv0GW2zgleHK+me4dbK7uenlZnDxzeDYZwNzlQf0S8rWdXhTaa7K8svRW2rKXSr8SckUgkq2xuMhQSOMDj8c2dQi5/4Ms4u+P/nEy4c28Sb05ijY9pS6F3wHAaIGjt7jlFD072QnQCqR1Q8tLEOYjQYe9mIjxMalpfDTIRqu58MB1kBdi+fet5eKR/7hDr+UcRBGAaW8mZHMTWXJG9ZxhecOtg737umL1rfe653mIIEb1pD4C9xEDMoPWwWQ10BueYqdsU3GMoqccgxZg9oWjMvSyL7UWNvUOJIbrEaZu3Di0TFRI91P5+c5MGNEOdaknEVecXTSAPF54tZqao+BkDP85nvEDE0UJCTkc9dY73Q8amxloSJu6Y0oM3GM6Z0hRgiJUABifS9VMFlgN87usXsWhfGyHNgicGDI6ZgFbM9xWg54HyS9ST4iuAJRciezHXPgUO/L4xbs0Lw9DrhjDivAyrZ1DTrvYmAF9xm78eDI7wzLhf1j6BqwER29Hj0GA7T/21Srhs8EqOY7/DD32ntn9nh38=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(86362001)(83380400001)(31696002)(31686004)(5660300002)(6666004)(508600001)(66476007)(66556008)(54906003)(7416002)(36756003)(4326008)(7696005)(38100700002)(53546011)(2906002)(8936002)(26005)(7406005)(316002)(6486002)(2616005)(186003)(956004)(110136005)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU8yRW1HcHVmNGI1M0xOVVlpTTVlVkhscVdHNjdoeWgyTFRXUzhGN0ZmV2Fh?=
 =?utf-8?B?Vm11TXRreGRMc28zTk56R2xmVTdpNGFEcDVPYkxRVmNIeXpvT2l2SzZvQVRk?=
 =?utf-8?B?cVVBeFlhOFVFVElCU2UxcExFb1RoMHAvak9IWGJ0ZmFpMmNncjhMWEx3WDdz?=
 =?utf-8?B?MjBRQW9mcTJhY1QzN0kxRlIwU0NTQ3hMcitzN0MzQmxwSHhMUXA1UGdmR055?=
 =?utf-8?B?MUd6eXRZOFJuOENIRmhDZS9FQWdsZVFqSGJjam4wQ3dTRnFyVURSNVhGQWlm?=
 =?utf-8?B?UnFXVjB5SE9DaUFwbDJJa21UTDdnK2ttOWpuSzN0Q21Uc2lxVkZqaVRKYU5a?=
 =?utf-8?B?NTdhbzMrS2dSZVhEVzVFb0JiR290RU5VZHNCOGxNa1h5WGRuLzVLRUIrWFNo?=
 =?utf-8?B?ODMxT1R5dFJ3bEMzZ1Z0RXUvMi9lYVNUMVJUWVJKWUw2S2hHWi9qVFFlVkRF?=
 =?utf-8?B?Qm51NEgvRzJnRk5RQUhLNklpYkZxTlN1OW05K0RFZ0VMSVo2WlpmZFhHYVBR?=
 =?utf-8?B?Z25MMHlqTEkzZ0R3alZHbWpCL2pSU3lHNExUMndvQmdhKzZyK2ZsREFrY3JM?=
 =?utf-8?B?VXM4WFlpNmh5RmFEeTh4RE1icS83UDhPN3FoUnlCOEx1ajBraGJaWHN5ZmNI?=
 =?utf-8?B?VWxtRzVoT0ZaRHVuRGRSaFZNSWN5QVN0VmFIcExoSVFwUThaYnljODVUdTU1?=
 =?utf-8?B?bEdkN3cwd0x2NWErYVlNYk4yYkRqUzJMZ3ppL2hxQnNEbmViUi9ubDN0WW9E?=
 =?utf-8?B?VFhpb29tbHp4UGVsK2JsRDdNSG9MbHM1Z0F6ZXpaTDBtc2F3YkFyRDhqZlFN?=
 =?utf-8?B?UkFsUTlxb250a2ZJVTdRWFJBMzhrc0kzNlVrQmhFL28vRTFYaDNlL2poamlE?=
 =?utf-8?B?enNKaDRZL0JVb0dSUXhEZldNZVFPMjBrNDdmbzVoMnBxS0ZWUjkwYk5YeE8v?=
 =?utf-8?B?V3ZKc09HTmJZbmlNVEMrZFFnTkdwc0krU1EveTRLWWhGTUwxWE1NemxiNVRo?=
 =?utf-8?B?S0FQYW16YjVNZnFqa1R0L21MTlRpTlZpejNjK01kR2RvMUhMekNKa0ppUGtX?=
 =?utf-8?B?TmptZnRDWFMyRFlaVVkrL1VwVmZ5TmFtdHpuczBUcVVwL2Z0NDVhOWFsTkdk?=
 =?utf-8?B?djIwREtFT0RIRTh4SEJzcjBiSmVRaUhZcXFMdFJtNFd2ODhtbXBJcDJtZzMv?=
 =?utf-8?B?UjgxNm9KVGpEdGN4bGZLSWU0eDhUazV2RTRSenM3ZDh5K0FVejFoSmw1bXpL?=
 =?utf-8?B?ay9kdit5SFdjZjhOeDhQNUNHdGc4b2lmd1RUc1VMVFJnOUgvcmVzZW1XNXN6?=
 =?utf-8?B?aWxuLzhLN0VFZ01xNjR6bXdmMTdZWmg2cndhTUMvTTg0YkNTUDMrTzgyazh1?=
 =?utf-8?B?QUcrWGlkMjJCc0JBQmxFVEd1Z2xnUnd3ekJOM216cHI4dGIraC9TOEtwT1Fz?=
 =?utf-8?B?R3pNeDJ6WXlIVDUxUlFuS2ZxdllOY1JwcWVDR09KOGpLWFM5ckhHWjl5ZnNQ?=
 =?utf-8?B?bms1WXpva1hNbU8rdU84L25WNkxGajN6Wm1JTHZEeUV0b29VUUlFRmpQOHI2?=
 =?utf-8?B?VWhZZHpsOVdUMjZlcDU0VEdpMFdpTG1YR3dKZ2czckQvTEx4Q0pSZnFoU3VT?=
 =?utf-8?B?UXR2bmNEM05tNm5GWVJFMUt4WVQzdzhsWm4xZ3hBRFdmMndCVm8xKzRqMHpW?=
 =?utf-8?B?RGV1V2tqak5qb2w1OGRzb20vekxlS2FtNERxTUNNaUdoRmh0SGFCMUlvSnRR?=
 =?utf-8?Q?CDaGhn9OPCVjPMOE8LbkrBDyQpgfJwAbmI9nBO/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4da11a-f64d-40b6-c77c-08d9843ce1a0
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 18:05:27.0369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uteJ0vJixvPZHe4/E5a2kuhAOQKuxSHHsCQRa+rqpSPeTgTcOQJNgrmKeuzC0tczpjMTxW9XEV+SS+l1kvvCRELE5Ent7tRVIcqX9C74GmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4261
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109300110
X-Proofpoint-GUID: 3B-x1EhcvY922cuQMzDNbKW9Ym4RHHjI
X-Proofpoint-ORIG-GUID: 3B-x1EhcvY922cuQMzDNbKW9Ym4RHHjI
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/23/21 4:31 PM, Kees Cook wrote:
> The /proc/$pid/wchan file has been broken by default on x86_64 for 4
> years now[1]. As this remains a potential leak of either kernel
> addresses (when symbolization fails) or limited observation of kernel
> function progress, just remove the contents for good.
> 
> Unconditionally set the contents to "0" and also mark the wchan
> field in /proc/$pid/stat with 0.

Hi all,

It looks like there's already been pushback on this idea, but I wanted
to add another voice from a frequent user of /proc/$pid/wchan (via PS).
Much of my job involves diagnosing kernel issues and performance issues
on stable kernels, frequently on production systems where I can't do
anything too invasive. wchan is incredibly useful for these situations,
so much so that we store regular snapshots of ps output, and we expand
the size of the WCHAN column to fit more data (e.g. ps -e -o
pid,wchan=WCHAN-WIDE-COLUMN). Disabling wchan would remove a critical
tool for me and my team.

 From my our team's feedback:
1. It's fine if this needs to have CAP_SYS_ADMIN to read for tasks not
    owned by the calling user; and for non-admin, if the symbolization
    fails, to return 0 just like kallsyms does for unprivileged users.
2. We don't care about the stack of an actively running process
    (/proc/$pid/stack is there for that). We only need WCHAN for
    understanding why a task is blocked.
3. Keeping the function / symbol name in the wchan is ideal (so we can
    pinpoint the exact area that a task is blocked at).

> This leaves kernel/sched/fair.c as the only user of get_wchan(). But
> again, since this was broken for 4 years, was this profiling logic
> actually doing anything useful?

This was only broken with CONFIG_UNWINDER_ORC. You may say this is the
default, but Ubuntu's latest kernel (5.11 in Hirsute) still ships with
CONFIG_UNWINDER_FRAME_POINTER, and many other distributions are the
same. Stable distributions have a lag time picking up new code, and even
longer lag picking up new configurations -- even new defaults.
(Especially when frame pointers are so useful for debugging...) So
saying that this was broken for 4 years is at best misleading. Plenty of
users have been happily using recent kernels when this was supposedly
"broken", on valid configurations, without any issues.

It looks like we've backed off of the decision to rip out 
/proc/$pid/wchan, but I just wanted to chime in, since it feels like the 
discussion is happening without much input from users.

Thanks,
Stephen
