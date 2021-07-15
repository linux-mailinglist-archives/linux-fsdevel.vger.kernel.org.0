Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3EF63C9C30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 11:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhGOJyO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 05:54:14 -0400
Received: from mail-eopbgr150138.outbound.protection.outlook.com ([40.107.15.138]:34789
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232473AbhGOJyL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 05:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioWqFV2n+jD//IAbChcBXO0TX9q/0QyChUdj9bt444stnNISDCQ/XVXe/eCXsqVd5G22xjKnlSGRVPjVld70aAwfUMPRTZJ9/ev5tg6RYNDeXYXICbASa1+TeGva78OU8TlnKua8ufGPHXK0WtdFiyrmq6sk4lIz96oAE/JRcz11iCd4XLgpTGCVDxpVz4f0JwZn3FACHcNlgbP59xOcBzEB6sQXI/WSKhK6TM6dzfxv599Z86TozkjfCXcOncVrByBecTEdrO6a6J5PXbKjK08OSHfC7nzQ4ugrVyMJDMbvln1sFN97pN4vc13Od7u73W8YVlWRlbc/vJ4P5xYtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3gAjB4FWuw8qQolwI7tL06hcn5LkIF90SsMYyZPhYQ=;
 b=OGsmCFKYTyrZTxtTrHXnEfOvN55lEIedZyhV+kCNALNhhkxOwubVTw6ZMP9fQEhOSBO0bjNUSuvu68GZBOxRxWRQv1cQtUGDGsanJwsonb2c6U/UsAN+XvCYEpKgV/mCdcKxGtcDpSczVHjpxrEuy/jcZwrxduQSj56ii0QbuqUxOPOCx5VF58KkIuESWI31nvl2UpPGYjwuGP3mXyWz/5J1vpueGDIlsa9/Tiyn/EAHs17pb0NtPWrbGl5eAkSe+MvCa/uBDhBt7gQ4nuQizmnTFfU5Q5y/Gdbq8628I8ipnFfXRyFwKR/ll6RTP7qVeXw/4wDJXte5+VvzulkPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3gAjB4FWuw8qQolwI7tL06hcn5LkIF90SsMYyZPhYQ=;
 b=fayQz33lDAMYEX0jGj7Xeh4EPDZjOkS1jIqzBrJ5FN0Km1ZLHMUP4bVeKAHr1KijxVrtzY0enLSIKxmYgRN+o9DBI9qooxApcRfJT0e6Kxs9lP8Pn3thNGJ9+pSICRego0fuI7cRQthikU6A/UtWMntlzkQKqyWLKcAEIMSTsAs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR08MB2832.eurprd08.prod.outlook.com (2603:10a6:802:25::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 09:51:14 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::c402:b828:df33:5694%7]) with mapi id 15.20.4331.023; Thu, 15 Jul 2021
 09:51:14 +0000
Subject: Re: [PATCH v4 2/2] tests: add move_mount(MOVE_MOUNT_SET_GROUP)
 selftest
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
References: <20210714161056.105591-1-ptikhomirov@virtuozzo.com>
 <20210714161056.105591-2-ptikhomirov@virtuozzo.com>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mattias Nissler <mnissler@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrei Vagin <avagin@gmail.com>, linux-api@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Message-ID: <d15401ca-f4f2-0042-62ff-a1b1dfa28548@virtuozzo.com>
Date:   Thu, 15 Jul 2021 12:51:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210714161056.105591-2-ptikhomirov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::13) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.100] (46.39.230.13) by FR3P281CA0063.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend Transport; Thu, 15 Jul 2021 09:51:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8afefefe-8dcf-4769-4aae-08d947761589
X-MS-TrafficTypeDiagnostic: VI1PR08MB2832:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB283284EBA37BFD79B9106AAAB7129@VI1PR08MB2832.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ld+Gogeqep6JjyvhAnYJoArvTiwluHbT8/HEethmX+4aDHD0nklv0YO67UkueeXWZRhaswPy6sktAk95BH4LRZUJUH5bMMXJ27ur6ZzqqakLFydFSi0z0FERpm+uz6ry9LB+94hKxPF+d04EDvGcQNKBrNirFuE+78+z87ZW1xOma6GVs5ijoHLPvttRsnfvKsYkKsgAbL2TR7buhJHuQCP5r/fvcLQXJj4w5ER5tc2pvcL1S+ZkNmQjfmB1H1FgMQfHYViu4N52eYuCXdq5HIqWo1xt8zYbaW3yANKzvrhcDACmjdtnZNwBf/yT5B+H7/MP3KTV8To9gNIP/t0f192JAnJfUGNGcIWbM/V6JSE1vpfVl1Zev/K0fH7o4uFBo3gBFb/N0zKnBcoNBe2ENqISU7whmquVEnERq3PguKMwu4ZDRWlnydENHRMcKpLLT/SDT+IDusL3Wymfz4Y1zQXouSlPEKa20leb/CrnJGOMiAShVNnhmU8kt9tOy93Oo7NURQymAMFobnNxdIEKkAOpyfOiIU9OOsls8zaf2v+aNxS/pJJluG1OYJtdrbO/k+Q2lHQUWrp+sgPBJ40dhmRiMiZQaq7GUWDMAaA64xw3wVn7L8Z6j58nVHwTlS7qPiCx9AJIng802qntG21XsBbalnT4cbM3+DOf9a5Gp565Q7Ag6zEfzSPsBr44xAR0X40JRW2Hp+TFey5wFmqPfVNuKdtcPAWyJuqu/S9BFJmh2PImFPsTK7f+PeZBBG0b5YCd4wdvsnPM09jg7bdCufpesWYgUKO4uTSZ2v7ZgXVJQfxFP80MfmystnAZ0rfUS4WRNGE1RciWgNArL6nbHnTKcFFHtnDfGBRt0GGx/as=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39840400004)(396003)(366004)(346002)(376002)(26005)(86362001)(53546011)(8676002)(4326008)(6666004)(66556008)(66476007)(66946007)(16576012)(54906003)(316002)(6486002)(2616005)(956004)(966005)(478600001)(8936002)(31696002)(5660300002)(52116002)(36756003)(30864003)(38100700002)(38350700002)(83380400001)(2906002)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGtKTnlYWWJGamZVaS9vV3RxWHdGOExjZDYvVkF1RlVic2sreW5iZ3Bqdm9V?=
 =?utf-8?B?cDJuY290anBGRkI5a0U5TmZPbEM5bitOVmpWUzFud3lJUkt5ZndVcTVsRGw3?=
 =?utf-8?B?ZmdFVkEvenRlTm5Za3cxWW5iS2lMNEVkYThvMm1iaFRUcDhBcVBBZmxUbVN5?=
 =?utf-8?B?aXdRN3JZNGJXdURhazg0ZmRLMW1RRDJiTXRsVlpYZldDWjJEb0hJVitWZEtj?=
 =?utf-8?B?MnFkKzYrWVl6SG9YTlljYXhjTU5sUWRON0tBWDE3MHZWLzAyRHRvelQvTmJC?=
 =?utf-8?B?R0NhSVB1UHVxR083SmFqNk9KbG92ZnMwY09wMlNNUEUwcHVIenc3aEtqOFJu?=
 =?utf-8?B?VGdrU3BrU1RLWTRvVytqWGFhZld6aThMa0Z5UkpwQk1BNVYydjA5dVNFbG9B?=
 =?utf-8?B?U09rVDlKdEUrZU05U2hjUG1PR1B5YU44Q0lJdTNDM0t0emd6SzVJZ3lPUytH?=
 =?utf-8?B?OVMxczRlTFFqaXZNaGxnc2VHbFZ1TzJFWVFySVBQa3RhdG1qK05vNnJlSWVw?=
 =?utf-8?B?eThEY0VyNEw0bENLOGVqdlJld3J5dDgwRU9hQ0dQUU52ZTBmeDBmbGgwdVJK?=
 =?utf-8?B?ZGNxRWEyTVpsMy8zU0t1c0FPTXp1eU5yWEY5alpKNDROM1ltWGs3UmVDTlVv?=
 =?utf-8?B?MjZ0N0NPZERyanN4SzQrc1dZQmRGNzBBalRQcGNQM0FWcjZDOWpqR2d2bVlm?=
 =?utf-8?B?MXJCL1V3eExXbnNaSmxDZThaMDFaWnE4RTdzRksrSDZTaWJCU2hvYmp2RFFR?=
 =?utf-8?B?cmdJWklVQW5NWnZuQWJhODdpdStYazFFbEkzMm44RDhCMWxJRUJuc053MitI?=
 =?utf-8?B?YTNsUnZaZ2gwbWR2UGFIeUVEdmJRYmJ6cU9uMzduVENxN2Rsbis2WHRVUXRD?=
 =?utf-8?B?dGFTamc2VXFueHhZaWIweGVHLzhTRkdoOXk4VW9EN1htKzI5L1FUVjNqcmVT?=
 =?utf-8?B?U0kyY08ybnhnZjlGMG1XYXpveStTWUEybnVOQTh6NUEwc2w0RDFydjV0REZM?=
 =?utf-8?B?SkgxcXBoMHhDVVRqeUtvamRPdk9mUjllUEpHN1U0OGhYQjNGODFiQmhkUno4?=
 =?utf-8?B?UmhITUpoVE5sdWJ3a2F1S05ORktGUjFObjJsdDFUYVArQVUxRmluei9mdkd4?=
 =?utf-8?B?MTk5NGw3SC9oQ0NpWVJMZm96VFM1QWlGSzV5UUFNOGM0cXk3bWNMemdqSC91?=
 =?utf-8?B?UlM5NVlHWkZTTlVLMENwWUhXdjJIcExIZGYzRno4anpueEc5a0t5T2c1ekZt?=
 =?utf-8?B?Qno0WmNjYXZOb2tLelYyTlNELzIzcEJ2QTMrVHZmWk43Y25PVXRWODY3dklo?=
 =?utf-8?B?OUlwYzNVWVMwQ1hpSnF0aEVneWlLd3phc0JGam1zaFFjdk1hbWpYWGxGMk5E?=
 =?utf-8?B?Vnk4TDNXRHluMlFBMmdHbG5mMWRWQkwvemtqWHZzb1hYb2VUMFN6bXhBaXd3?=
 =?utf-8?B?N2xPaGRleS92NDArMzExdzlHdmdmSEZLMm1zRU5FbFVaQk16SjNSdTBzYjRI?=
 =?utf-8?B?RE9XZ0ZqakZWNy85VW1vTWlVMDA0a1phVzlGc2NWdkFyZ3ZtRHhxZFNBMGt0?=
 =?utf-8?B?cVVZSEttZFovMno3VnJDRjZST0xIdE8zdmtwWndzZk5YN3VKSFJiMHhRZXht?=
 =?utf-8?B?S1d0QW1QaVRZZzhHTzVMb211L1hBZmdYQitVWVhDcklhdnc4dDhYWEE5ZVdI?=
 =?utf-8?B?b2YyQnBlVUpnYUNpSXhlNmRoSzdjOWpNTDRTekRZeEZTaEtZcGhZRmFvWk05?=
 =?utf-8?Q?bO0GeQ04zpRt5faxu4g4eKoBB6LNbNkRZyKZlO6?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8afefefe-8dcf-4769-4aae-08d947761589
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:51:14.4506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yg01EuVQVS/TxQziZORcYaq5DdS1hpOL4ATsz5z9aOg3u8ti23prQ44bIvM3pwJpacOMYs2jSb8Cpw4dS2VBzbBA7RQpqlJOU4ZESkbym2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2832
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding everybody back to CC, sorry I accidentally dropped all CC in the 
2/2 selftest patch.

On 14.07.2021 19:10, Pavel Tikhomirov wrote:
> Add a simple selftest for a move_mount(MOVE_MOUNT_SET_GROUP). This tests
> that one can copy sharing from one mount from nested mntns with nested
> userns owner to another mount from other nested mntns with other nested
> userns owner while in their parent userns.
> 
>    TAP version 13
>    1..1
>    # Starting 1 tests from 2 test cases.
>    #  RUN           move_mount_set_group.complex_sharing_copying ...
>    #            OK  move_mount_set_group.complex_sharing_copying
>    ok 1 move_mount_set_group.complex_sharing_copying
>    # PASSED: 1 / 1 tests passed.
>    # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> 
> ---
> I took mount_setattr test as an example, I'm not to experienced in
> selftests so hope I'm not doing something wrong here.
> 
> I implemented a testcase having in mind the way how I plan to use this
> interface in criu, so it's not simply copying sharing between two nearby
> mounts but it also adds some userns+mntns-es to test cross-namespace
> copying.
> 
> Note: One can also test MOVE_MOUNT_SET_GROUP via zdtm tests on criu
> mount-v2 POC: https://github.com/Snorch/criu/commits/mount-v2-poc
> 
> v3: add some test
> 
> ---
>   tools/testing/selftests/Makefile              |   1 +
>   .../selftests/move_mount_set_group/.gitignore |   1 +
>   .../selftests/move_mount_set_group/Makefile   |   7 +
>   .../selftests/move_mount_set_group/config     |   1 +
>   .../move_mount_set_group_test.c               | 375 ++++++++++++++++++
>   5 files changed, 385 insertions(+)
>   create mode 100644 tools/testing/selftests/move_mount_set_group/.gitignore
>   create mode 100644 tools/testing/selftests/move_mount_set_group/Makefile
>   create mode 100644 tools/testing/selftests/move_mount_set_group/config
>   create mode 100644 tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index fb010a35d61a..dd0388eab94d 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -35,6 +35,7 @@ TARGETS += memory-hotplug
>   TARGETS += mincore
>   TARGETS += mount
>   TARGETS += mount_setattr
> +TARGETS += move_mount_set_group
>   TARGETS += mqueue
>   TARGETS += nci
>   TARGETS += net
> diff --git a/tools/testing/selftests/move_mount_set_group/.gitignore b/tools/testing/selftests/move_mount_set_group/.gitignore
> new file mode 100644
> index 000000000000..f5e339268720
> --- /dev/null
> +++ b/tools/testing/selftests/move_mount_set_group/.gitignore
> @@ -0,0 +1 @@
> +move_mount_set_group_test
> diff --git a/tools/testing/selftests/move_mount_set_group/Makefile b/tools/testing/selftests/move_mount_set_group/Makefile
> new file mode 100644
> index 000000000000..80c2d86812b0
> --- /dev/null
> +++ b/tools/testing/selftests/move_mount_set_group/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for mount selftests.
> +CFLAGS = -g -I../../../../usr/include/ -Wall -O2
> +
> +TEST_GEN_FILES += move_mount_set_group_test
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/move_mount_set_group/config b/tools/testing/selftests/move_mount_set_group/config
> new file mode 100644
> index 000000000000..416bd53ce982
> --- /dev/null
> +++ b/tools/testing/selftests/move_mount_set_group/config
> @@ -0,0 +1 @@
> +CONFIG_USER_NS=y
> diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> new file mode 100644
> index 000000000000..ca0c0c2db991
> --- /dev/null
> +++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
> @@ -0,0 +1,375 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +#include <sched.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <sys/mount.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <stdbool.h>
> +#include <stdarg.h>
> +#include <sys/syscall.h>
> +
> +#include "../kselftest_harness.h"
> +
> +#ifndef CLONE_NEWNS
> +#define CLONE_NEWNS 0x00020000
> +#endif
> +
> +#ifndef CLONE_NEWUSER
> +#define CLONE_NEWUSER 0x10000000
> +#endif
> +
> +#ifndef MS_SHARED
> +#define MS_SHARED (1 << 20)
> +#endif
> +
> +#ifndef MS_PRIVATE
> +#define MS_PRIVATE (1<<18)
> +#endif
> +
> +#ifndef MOVE_MOUNT_SET_GROUP
> +#define MOVE_MOUNT_SET_GROUP 0x00000100
> +#endif
> +
> +#ifndef MOVE_MOUNT_F_EMPTY_PATH
> +#define MOVE_MOUNT_F_EMPTY_PATH 0x00000004
> +#endif
> +
> +#ifndef MOVE_MOUNT_T_EMPTY_PATH
> +#define MOVE_MOUNT_T_EMPTY_PATH 0x00000040
> +#endif
> +
> +static ssize_t write_nointr(int fd, const void *buf, size_t count)
> +{
> +	ssize_t ret;
> +
> +	do {
> +		ret = write(fd, buf, count);
> +	} while (ret < 0 && errno == EINTR);
> +
> +	return ret;
> +}
> +
> +static int write_file(const char *path, const void *buf, size_t count)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd = open(path, O_WRONLY | O_CLOEXEC | O_NOCTTY | O_NOFOLLOW);
> +	if (fd < 0)
> +		return -1;
> +
> +	ret = write_nointr(fd, buf, count);
> +	close(fd);
> +	if (ret < 0 || (size_t)ret != count)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int create_and_enter_userns(void)
> +{
> +	uid_t uid;
> +	gid_t gid;
> +	char map[100];
> +
> +	uid = getuid();
> +	gid = getgid();
> +
> +	if (unshare(CLONE_NEWUSER))
> +		return -1;
> +
> +	if (write_file("/proc/self/setgroups", "deny", sizeof("deny") - 1) &&
> +	    errno != ENOENT)
> +		return -1;
> +
> +	snprintf(map, sizeof(map), "0 %d 1", uid);
> +	if (write_file("/proc/self/uid_map", map, strlen(map)))
> +		return -1;
> +
> +
> +	snprintf(map, sizeof(map), "0 %d 1", gid);
> +	if (write_file("/proc/self/gid_map", map, strlen(map)))
> +		return -1;
> +
> +	if (setgid(0))
> +		return -1;
> +
> +	if (setuid(0))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int prepare_unpriv_mountns(void)
> +{
> +	if (create_and_enter_userns())
> +		return -1;
> +
> +	if (unshare(CLONE_NEWNS))
> +		return -1;
> +
> +	if (mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static char *get_field(char *src, int nfields)
> +{
> +	int i;
> +	char *p = src;
> +
> +	for (i = 0; i < nfields; i++) {
> +		while (*p && *p != ' ' && *p != '\t')
> +			p++;
> +
> +		if (!*p)
> +			break;
> +
> +		p++;
> +	}
> +
> +	return p;
> +}
> +
> +static void null_endofword(char *word)
> +{
> +	while (*word && *word != ' ' && *word != '\t')
> +		word++;
> +	*word = '\0';
> +}
> +
> +static bool is_shared_mount(const char *path)
> +{
> +	size_t len = 0;
> +	char *line = NULL;
> +	FILE *f = NULL;
> +
> +	f = fopen("/proc/self/mountinfo", "re");
> +	if (!f)
> +		return false;
> +
> +	while (getline(&line, &len, f) != -1) {
> +		char *opts, *target;
> +
> +		target = get_field(line, 4);
> +		if (!target)
> +			continue;
> +
> +		opts = get_field(target, 2);
> +		if (!opts)
> +			continue;
> +
> +		null_endofword(target);
> +
> +		if (strcmp(target, path) != 0)
> +			continue;
> +
> +		null_endofword(opts);
> +		if (strstr(opts, "shared:"))
> +			return true;
> +	}
> +
> +	free(line);
> +	fclose(f);
> +
> +	return false;
> +}
> +
> +/* Attempt to de-conflict with the selftests tree. */
> +#ifndef SKIP
> +#define SKIP(s, ...)	XFAIL(s, ##__VA_ARGS__)
> +#endif
> +
> +#define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
> +#define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
> +
> +static int move_mount_set_group_supported(void)
> +{
> +	int ret;
> +
> +	if (mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
> +		  "size=100000,mode=700"))
> +		return -1;
> +
> +	if (mount(NULL, "/tmp", NULL, MS_PRIVATE, 0))
> +		return -1;
> +
> +	if (mkdir(SET_GROUP_FROM, 0777))
> +		return -1;
> +
> +	if (mkdir(SET_GROUP_TO, 0777))
> +		return -1;
> +
> +	if (mount("testing", SET_GROUP_FROM, "tmpfs", MS_NOATIME | MS_NODEV,
> +		  "size=100000,mode=700"))
> +		return -1;
> +
> +	if (mount(SET_GROUP_FROM, SET_GROUP_TO, NULL, MS_BIND, NULL))
> +		return -1;
> +
> +	if (mount(NULL, SET_GROUP_FROM, NULL, MS_SHARED, 0))
> +		return -1;
> +
> +	ret = syscall(SYS_move_mount, AT_FDCWD, SET_GROUP_FROM,
> +		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
> +	umount2("/tmp", MNT_DETACH);
> +
> +	return ret < 0 ? false : true;
> +}
> +
> +FIXTURE(move_mount_set_group) {
> +};
> +
> +#define SET_GROUP_A "/tmp/A"
> +
> +FIXTURE_SETUP(move_mount_set_group)
> +{
> +	int ret;
> +
> +	ASSERT_EQ(prepare_unpriv_mountns(), 0);
> +
> +	ret = move_mount_set_group_supported();
> +	ASSERT_GE(ret, 0);
> +	if (!ret)
> +		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
> +
> +	umount2("/tmp", MNT_DETACH);
> +
> +	ASSERT_EQ(mount("testing", "/tmp", "tmpfs", MS_NOATIME | MS_NODEV,
> +			"size=100000,mode=700"), 0);
> +
> +	ASSERT_EQ(mkdir(SET_GROUP_A, 0777), 0);
> +
> +	ASSERT_EQ(mount("testing", SET_GROUP_A, "tmpfs", MS_NOATIME | MS_NODEV,
> +			"size=100000,mode=700"), 0);
> +}
> +
> +FIXTURE_TEARDOWN(move_mount_set_group)
> +{
> +	int ret;
> +
> +	ret = move_mount_set_group_supported();
> +	ASSERT_GE(ret, 0);
> +	if (!ret)
> +		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
> +
> +	umount2("/tmp", MNT_DETACH);
> +}
> +
> +#define __STACK_SIZE (8 * 1024 * 1024)
> +static pid_t do_clone(int (*fn)(void *), void *arg, int flags)
> +{
> +	void *stack;
> +
> +	stack = malloc(__STACK_SIZE);
> +	if (!stack)
> +		return -ENOMEM;
> +
> +#ifdef __ia64__
> +	return __clone2(fn, stack, __STACK_SIZE, flags | SIGCHLD, arg, NULL);
> +#else
> +	return clone(fn, stack + __STACK_SIZE, flags | SIGCHLD, arg, NULL);
> +#endif
> +}
> +
> +static int wait_for_pid(pid_t pid)
> +{
> +        int status, ret;
> +
> +again:
> +        ret = waitpid(pid, &status, 0);
> +        if (ret == -1) {
> +                if (errno == EINTR)
> +                        goto again;
> +
> +                return -1;
> +        }
> +
> +        if (!WIFEXITED(status))
> +                return -1;
> +
> +        return WEXITSTATUS(status);
> +}
> +
> +struct child_args {
> +	int unsfd;
> +	int mntnsfd;
> +	bool shared;
> +	int mntfd;
> +};
> +
> +static int get_nestedns_mount_cb(void *data)
> +{
> +	struct child_args *ca = (struct child_args *)data;
> +	int ret;
> +
> +	ret = prepare_unpriv_mountns();
> +	if (ret)
> +		return 1;
> +
> +	if (ca->shared) {
> +		ret = mount(NULL, SET_GROUP_A, NULL, MS_SHARED, 0);
> +		if (ret)
> +			return 1;
> +	}
> +
> +	ret = open("/proc/self/ns/user", O_RDONLY);
> +	if (ret < 0)
> +		return 1;
> +	ca->unsfd = ret;
> +
> +	ret = open("/proc/self/ns/mnt", O_RDONLY);
> +	if (ret < 0)
> +		return 1;
> +	ca->mntnsfd = ret;
> +
> +	ret = open(SET_GROUP_A, O_RDONLY);
> +	if (ret < 0)
> +		return 1;
> +	ca->mntfd = ret;
> +
> +	return 0;
> +}
> +
> +TEST_F(move_mount_set_group, complex_sharing_copying)
> +{
> +	struct child_args ca_from = {
> +		.shared = true,
> +	};
> +	struct child_args ca_to = {
> +		.shared = false,
> +	};
> +	pid_t pid;
> +	int ret;
> +
> +	ret = move_mount_set_group_supported();
> +	ASSERT_GE(ret, 0);
> +	if (!ret)
> +		SKIP(return, "move_mount(MOVE_MOUNT_SET_GROUP) is not supported");
> +
> +	pid = do_clone(get_nestedns_mount_cb, (void *)&ca_from, CLONE_VFORK |
> +		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
> +	ASSERT_EQ(wait_for_pid(pid), 0);
> +
> +	pid = do_clone(get_nestedns_mount_cb, (void *)&ca_to, CLONE_VFORK |
> +		       CLONE_VM | CLONE_FILES); ASSERT_GT(pid, 0);
> +	ASSERT_EQ(wait_for_pid(pid), 0);
> +
> +	ASSERT_EQ(syscall(SYS_move_mount, ca_from.mntfd, "",
> +			  ca_to.mntfd, "", MOVE_MOUNT_SET_GROUP
> +			  | MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH),
> +		  0);
> +
> +	ASSERT_EQ(setns(ca_to.mntnsfd, CLONE_NEWNS), 0);
> +	ASSERT_EQ(is_shared_mount(SET_GROUP_A), 1);
> +}
> +
> +TEST_HARNESS_MAIN
> 

-- 
Best regards, Tikhomirov Pavel
Software Developer, Virtuozzo.
