Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152D06F90F6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjEFJi7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 05:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEFJi5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 05:38:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64782719;
        Sat,  6 May 2023 02:38:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3463NJXw004432;
        Sat, 6 May 2023 09:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=t4J88bVYJezyQJHlqfQB/uLFXmOvdWfadhD6/e86Yls=;
 b=K/PX107W79mgkDQAc8J3ZIsWPuhFy/G0QUNgqw2LzJdMtutzg4rVjWVAkjJBfWFUPETV
 07rjc1M34Mkm5/js5mHlP2x9mC6WLdw4/jn7HPEMQStBov87uCDnAV7vpy5Sc9rCQUsa
 jqux64ADX2RbGFZqDEyWCjiBmNOZs+sHJrvUGVdMhvcvTyuc7+r1+LkXyDSx09z0BUXd
 I8RYWQNDqoI3gU0bmmVLjmUdl1KU5tlwdZbqtqtDQc/og23oQYoag5DEKx4ipjvzwAhq
 Xo68uZJXb1yehQZ0vaTntJORZc3LVX9T5CmMBNY8umYqBuZ5WtYJyz5gr7hvotXkA7yO +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qdexdgdfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 09:38:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3466EMi1038310;
        Sat, 6 May 2023 09:38:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3ga01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 09:38:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0MwT8Qt3sHLkgTTX17Mp46HrlCM4/cWg+VT9ShH2G7zlsDXDH7PKgyDdtmDnoR1yVig5nqRSOvbxBJWbkjYMNTH3Z+hhkkMvf7A+onNYMUjyCHfQZhdfCkUKipQhAqOkersPM9ak8dY2qvnVG0CVcRB5QMz0eYCSQDneAqr5O+ohq/dPmZxIV9k3tZXlTJ5Eb7phLHK//9qtgB0cALsE31cKpbC8Qy07L+ZqavcHtQyE3jDg78TZLkiJcw0H4pyb5ODFp0WarsZKOcjZimfuEi/+08u+0PJt8aSMBKgy5z3ySKfSxDenFl1yvHBGPqBpmK1lS+7w+Hhh1zpYM0Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4J88bVYJezyQJHlqfQB/uLFXmOvdWfadhD6/e86Yls=;
 b=ZJrhQdZZpEAbSzqUDSuEBJq+OwwGi/P2GqO6YYeICOrkob4Dmqog8kx2w5teLrrP+1gx/TDm6Eslvh2q1HwwDuXMswQGfDZFqzA5ierPtuRqA7c+c+BWlZS+aHlUHorMPtTUqnGgSH+4IfX5LhnjDdyw6yqRApFUkQ9CtLkK1OM9pGii1KwJ1pT1LvJOq3v8A3MculDgjV5eL7gniZGiEY+q/DRlDXGipPA0Lu/1YXoiYUxIkKKpOF0pO55nM9uK+mcGBH4Pal2BgFb14lUNLhkpRKMskMBkvvNiHoac4Qak6SpA7pFvPReFV4aXIzWGc2rKD9VYNc4jaRO1nKYQ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4J88bVYJezyQJHlqfQB/uLFXmOvdWfadhD6/e86Yls=;
 b=akKT91M99YzB6ZckTNfAe4Ew0GQ/CipuiF5kslVBP6avS8TIv6fqdxXm8C9PR9hGDw9qUt4uxhPdRUs1uc4Hlt4wXpCpjk2kuJy3k8i+JuAHPIcD7hEIfDPQMk//giOjWCe5BoM9oeuNHIvA96JPpzFZmKoR+CEdB2pGHvocnJU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 09:38:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.029; Sat, 6 May 2023
 09:38:06 +0000
Message-ID: <46eaa9a8-32c8-b803-cc8d-a4f4a2c900bc@oracle.com>
Date:   Sat, 6 May 2023 10:38:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <90522281-863f-58bf-9b26-675374c72cc7@oracle.com>
 <20230505231816.GM3223426@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230505231816.GM3223426@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0328.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 15eec397-50d3-4d6f-0e1b-08db4e159835
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owDtlN72cKsXlr/NyRAj81may9W01JCgQ648bOxuiLwKv9ERi66AxQS3eVk/rovoP+lCv2vc9WpaNH9cK0uQVULffOTJ3dKIyrDnVZffcGK7Mje6DAolhq2ensw5FhILZ/F7X0jU9/lh1NgIVJH3LdznWFAYRfiCHqXj+L7NSMRyyuWGNd7Te4YLXv/7G24aMn5yzTBqQzc87RoXUODNJUJQrbzOhAQwXY7oULzRxEPXA1qxMp5IkjsTyo+MBiBIXGTu6cZLtJZWfaH2d7KjrDR8NmhbWBiBF6RDJJx+j0Qb1kxQ9XKk/eKep6pb0zAFH8/TYIwoXnFPfqX8djYec1bXx/5p6Vzi9CjD35jTFRjv+8AioL7AFiE/wHXRKyZBXCVfj6dC6ZyN29OSJj6V42+X6b/OCM3ql/EnkolSJAbMk3MU0CByfJUZhnwkfKOMHtAXZk4VChhhURYoOkzRizX4vp3Ls0gc+Ispq9ZIDJNT7H7Hc1QUs02W0A7EiGCbQp2HZ5jO32KtRPpm63cqj2YJdlre9nXUgs2UiZQk6cdDII7oPHJjmb/yCqFVtl/7l6Nbp6oK6oeahNL4pnycoI3CXXRxNjkKGMKQEfaweS595R+b+splSp9cuNLik1QBXpufyhk4MiYVQYf2KGm1rfCEJoKpeBJOXlyWikQ2xPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(31686004)(66899021)(6916009)(36916002)(4326008)(66946007)(66476007)(66556008)(6666004)(6486002)(478600001)(316002)(31696002)(36756003)(86362001)(83380400001)(2616005)(53546011)(107886003)(6512007)(26005)(6506007)(41300700001)(8676002)(8936002)(5660300002)(2906002)(7416002)(30864003)(186003)(38100700002)(60764002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1VtK2tVcmJOMUxUNStyTmNIQ2I5RDQrdzlCWjJWaE5TUFZhcG1DQmdhMHll?=
 =?utf-8?B?QkRNc0hLNVlLMkdRMGJFamlNTlJUWmE4dDR2dXV5Vy9XRk0yeUhtV09Hendv?=
 =?utf-8?B?SVcwUUJRbVR5bVhJMHBFVTA1UTFlOTIxVkJ6K1RybmQweUxiMEo2aWE3SmVz?=
 =?utf-8?B?NzJ0WWN1ai9TUFFMMGlnbXBqUnpFRmZGd05WWmRHeVAzOUhrRnppVC9va1lt?=
 =?utf-8?B?RGZseW0rY04vMGljV085SlIxYytqZ0dFbHdTcFFjdjY0T0hqQ3VrYURPcHhU?=
 =?utf-8?B?SXUvUk9aODR3TWE3QldKU2FxYjhPV2hlNjNqRWE4RlFNYXNnaFd2dWdwVXox?=
 =?utf-8?B?TFFybkpjZXowMTBIMy9RTkhpeEhneFNVcUhVQWdSVjJUY0xyeDRxYnRJQ2Js?=
 =?utf-8?B?YXR6L1Q3T2trRzUyTWdQY1dzalcraTgyazlYRHlYNkVNSTAwMHhZZkk5b1cy?=
 =?utf-8?B?alJiVGVYeDRUTDM1cEpJUUxHZ2dpSXpvMjloa2c1WjdRUmw4bDVDSXpFNzdY?=
 =?utf-8?B?T1p6N3lpa2pPWnc1ckFackx5UlhMaTVacTF0dVJ1SGJYQTFPM3oreU13b013?=
 =?utf-8?B?UTFFWnZkYUo3TWoraitSS3k2amtoN3F1ZXlLdDNnbmd1YVlaRU1INkNVS0pm?=
 =?utf-8?B?ZEFRWlYvU3Q5VUNQRTR6TjE2Zkc5N0thOEtWMEpyS3FvbGR5L0pCdXNKZXVC?=
 =?utf-8?B?eHduWTVhaGd6bm9QL1NnQmNHSTRoN2hWVkJZa2FwSndpVTd3NFk1V1ZhY2VL?=
 =?utf-8?B?SDd5bWRHS250clFDOUR4aGcvNHFreE5vRHFHQlV3eG5uWFloTnVwVXBkMTNj?=
 =?utf-8?B?K0QrcENka0tNTlNvVG9NMGg0c3FpSmoyNzRrN0VxNlBUNHVZelRiSTMzK2hK?=
 =?utf-8?B?L1dxclhFOVVCL0JCSHBSNkZyaERxOTRhanhlcDZycUdjTXBPa3pSbklKMlhY?=
 =?utf-8?B?Nnc3TnBTZytpMlFTZVRLUk9JbFJHZDNoTk1ZL3N3TnAzRlRkR2wzRHZWbVNq?=
 =?utf-8?B?dE9UQjFBcWNRdVA2RkxpTmZlbVBlT1Rvd3dORDV2OWx1SURSNWdSU1RQdys4?=
 =?utf-8?B?YXc3aUQ2VTA1SUNsR3k4bXB3NDQvNURUTmRFTHIvbm5OSC9xdmJ3ZEZ3Qk5q?=
 =?utf-8?B?dS82bUZrSFBjNTc4OW5iSSsraXNVa2NUdDBHSE11bnlBbVNsekNjTDl1a09J?=
 =?utf-8?B?QkswL041Z3pHcTU1VDh0eHdRUDd1bXNLbzZVa0FGRTBIWGxNSFpjOXMvWUoy?=
 =?utf-8?B?UHdhd3hjVzdNbmVVbUtUM3ZtdG9xdyt1VXBJRzAvZklDb3RKejNhVkt2dk9T?=
 =?utf-8?B?MWZJb2VrTEZlTG8zOFN3QUtlcjEzNXFvd3g5TkJIMngyNWgrR21DOTdWTXRS?=
 =?utf-8?B?M3hpb3hnNHFERDFlQUJBaUQ2bis4Z2RvM25VcllPZjFicElDNWFrQ0pQSnJX?=
 =?utf-8?B?MFFVSzlHcUVRUmNWcGhXVk1lY0xMbk5IeGdKQ1ZFK2swcDhndGVkejJKYys0?=
 =?utf-8?B?YnVEbjN0MDY3R29mOU9WQUIzYTRsZmN5cUJTVmR6UCt1Z2NOQ2kwaFVYMWJH?=
 =?utf-8?B?SkNkY2NiSXpLUHFObXlycXR2Q2hoK2w0OTBpRGM3ZGFxblByL2hJSzhhQXRI?=
 =?utf-8?B?Y0l4Nm9vTkh4ejdOTytLWjNVeWFlaFVFWUgwNU1CZUU4dmduOHUyNzJmdGtQ?=
 =?utf-8?B?azYzRE9BTkM4Qm0xalZhL2ZsQmhwb3BnVWF0MHlFOUNidGxXR2Z0R0lZZmcw?=
 =?utf-8?B?TGtGdUsvNEZmWE1DVTN2QUtBbnBLL0NHZ3Z5b210cXcrM2V1dVhLYmxTV1Jt?=
 =?utf-8?B?VnhLOHFFTVJNQ1k0Ykg1MnlPd2hlMkh5SndHOW44QkNIdkd4Sk1namFxWFRS?=
 =?utf-8?B?WVBoS1o2bzgyblE3ejJkNFptdEV3L0lxajhpaHppRUFrSE82V3o1clRDWmRO?=
 =?utf-8?B?YXZRTkFmbVlORGRWaW9EVkFwV1ByaDNxaW5OelpBaExYOUZ6bXVPQW02ZWhw?=
 =?utf-8?B?TG5wVFp0Q3Fhc2U1ejVCVTdzbnptZHgyMjJuTlFMQVY2WGs5YXJXemVZSllS?=
 =?utf-8?B?QmNpWmZJcGFoYVNjUVpRZ0YweUNGc1Y5N1hYOXRCSzc2eURzcDR2ODZlcHlr?=
 =?utf-8?Q?N+G9VIrLUR9CrByI/zq5PDfNd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDBPczRwQUF4V0paQkF3UHJWR1FpUi85T3BQT2QvcktCYmdLZUlRQ1dUbGtI?=
 =?utf-8?B?dHVhNmQyV3dwL0RPKzJCalo5SStNTkFpb215TW5WRWRWVSs0TWowWFJjSjR6?=
 =?utf-8?B?ZzM2MGF0K0dFVXk0VVBMQ3ltWXVGMUJBVldYcXlXWmtKM1ZiUngrY1ZJUzh4?=
 =?utf-8?B?cHJnR3ZhdjFCei9xS0U5OUFNZVUydVkrSUNKMEpybjh0dVcrVEI4SFZtd0FB?=
 =?utf-8?B?TE10TXZRU25OUDlIOWZ1Rzhoa3JYT0hnQTdnMVJQSHhrSzQ1OFV6Ry9GdTJN?=
 =?utf-8?B?N3I5U3hoOWdLaWNwUkFJMDhBRmpmMWFSZEQya1p4Wkd1VVhZakl4UXlCcFMr?=
 =?utf-8?B?SWczMzhJOGZMZm1ZVHpOVmpBYkZwN3ZlTTRWNGo0dFFIaVh1NEt0Q00vLzBQ?=
 =?utf-8?B?Z0JJczJaYXN6Q0h3RmZSQWR1SHZneEdmSlBzSU9OYzJ1TThWdjV3bTAzUEE4?=
 =?utf-8?B?cTdmamFOK29ESTJqVDlURXRpOWpyY3dTYXBhZVVCcURLK2tMK3I3bXBKYThL?=
 =?utf-8?B?RVgzQ3JZcW5obzEwWHk4emVrM1AxVGlFN0tTRlE2WnlBOVViZ0x3dENlbi8y?=
 =?utf-8?B?MXRTUnBrNTZwbTJTWGNoNGdOYWRRR2RkVXlFS3ZaNnpVRHJFeW4wZnduUnNa?=
 =?utf-8?B?M3JZYmkzZnlsY24zS1lUcmtET3lUMXY5WnNYWlVvb0FMUW1jOXh6clF4b3l1?=
 =?utf-8?B?c0VkRFFvbExLdHRCSmYzS2RMQklRNmpXc1VNNmp5d0JIczF5YjhmTHVWSXJH?=
 =?utf-8?B?L0lna0lCMmZ5eHFUeWIvMG9pN2tKUENjd3QrME5KejBWVmkyS1BTWHRJK0la?=
 =?utf-8?B?Y2FQTHAzY0t6SVdnS1Q0MXN5dmM4eWwvaGlRdFhqeWtxWU1Ld3BtS0lYS0Fz?=
 =?utf-8?B?aWc0Ymx1TkQ5aE55dGZuOUF6cE9LdUttVTdhL25OYzRvM1IzWDArcUZBMDZj?=
 =?utf-8?B?cWZhaU9OUWhuWXRSZEc0S2xCbTVha3RoL0JmejZSQWVUZEtRSnI1TDAzLzNR?=
 =?utf-8?B?eHRmeURBVHYwZXltN0ZZOGE2VFpQNnNKdmxhNEtvZHZKeFVFWGxRbC9YMUhM?=
 =?utf-8?B?TGRFSlVXMC9jYUhnZ25YYnpNV3pLZ0NWYUVRZ0tiWVNGbDd1RjFiMlpudFVV?=
 =?utf-8?B?MytYL1FZbVRwSy9vUFZFdlAwdUJGZ3Z2SDNSUXpQdUhrekxPS2lHQkx0NktN?=
 =?utf-8?B?WjJ5NmU1YXBSTExkNmpzQXN1NzlkK2VuVHFmdC95YnJoYXVqc1ArTG9PNHMr?=
 =?utf-8?B?RmlQNHZ6SDJBbGhYcDJKQk00d0NuNmtiZUU5by9oNW9DYVc1Y0ZVRGRYejh3?=
 =?utf-8?B?SS9wbWpiYjU3dnBuRHJPRDNDcVFEUGVWdUdEdHJMTDBBYXNxa3RCSUZoV0Z0?=
 =?utf-8?B?eDQ0SXI4WWVTM2dMNitveVRnaEcrWDhOakhMNjlUaWVsSnVHSVJLSlI2d1pH?=
 =?utf-8?B?S3NvSVZRR3RvWDdLTkZ1RHZrcm01WXdmbncwSXNvNXppTzZnSGRldklEWEtR?=
 =?utf-8?B?eU9jM3ZKdlVhRm9KcFZlaG9YNzgvUTg4ZVd5YTVtd2pBQi9kT3M4aDRRY3ZB?=
 =?utf-8?Q?gzkRIxBXu6L/0a3z1PxjR7uh4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15eec397-50d3-4d6f-0e1b-08db4e159835
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 09:38:06.0485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DarRnkDBCwThW+rjwVGOqH1SLmKixLtkzLdbnKcorjsTegfb83HlZa0juDxu5dA7SWYU/gHsTqrCeeFbIs6KhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_06,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060073
X-Proofpoint-ORIG-GUID: O9fUbaYMlnVOnUhDKOSLUNYankvSm9v4
X-Proofpoint-GUID: O9fUbaYMlnVOnUhDKOSLUNYankvSm9v4
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 06/05/2023 00:18, Dave Chinner wrote:

Hi Dave,

>> Consider iomap generates an atomic write bio for a single userspace block
>> and submits to the block layer - if the block layer needs to split due to
>> block driver request_queue limits, like max_segments, then we're in trouble.
>> So we need to limit atomic_write_unit_max such that this will not occur.
>> That same limit should not apply to atomic_write_max_bytes.
> Except the block layer doesn't provide any mechanism to do
> REQ_ATOMIC IOs larger than atomic_write_unit_max. So in what case
> will atomic_write_max_bytes > atomic_write_unit_max ever be
> relevant to anyone?

atomic_write_max_bytes is only relevant to the block layer.

Consider userspace does a single pwritev2 RWF_ATOMIC call of size 1M and 
offset aligned to 8K, which is 128x 8k userspace data blocks. It so 
happens that this write spans 2x extents right in the middle (for 
simplicity of the example), so iomap produces 2x bios, each of size 
512K. In this example atomic_write_max_bytes is 256K. So when those 2x 
bios are submitted to the block layer, they each need to be split into 
2x 256K bios - so we end up with a total of 4x 256K bios being submitted 
to the device. Splitting into these 4x 256K bios will satisfy the 
guarantee to not split any 8k data blocks.

When the kernel handles this pwritev2 RWF_ATOMIC call, it deduces the 
userspace block size, but does not always split into multiple bios each 
of that size. When iomap or block fops creates a bio, it will still fill 
the bio as large as it can, but also it needs to trim such that it is 
always a multiple of the userspace block size. And when we submit this 
bio, the block layer will only split it when it needs to, e.g. when bio 
exceeds atomic_write_max_bytes in size, or crosses a boundary, or any 
other reason you can see in bio_split_rw(). Please see patch 8/16 for 
how this is done.

> 
>> b. For NVMe, atomic_write_unit_max and atomic_write_max_bytes which the host
>> reports will be the same (ignoring a.).
>>
>> However for SCSI they may be different. SCSI has its own concept of boundary
>> and it is relevant here. This is confusing as it is very different from NVMe
>> boundary. NVMe is a media boundary really. For SCSI, a boundary is a
>> sub-segment which the device may split an atomic write operation. For a SCSI
>> device which only supports this boundary mode of operation, we limit
>> atomic_write_unit_max to the max boundary segment size (such that we don't
>> get splitting of an atomic write by the device) and then limit
>> atomic_write_max_bytes to what is known in the spec as "maximum atomic
>> transfer length with boundary". So in this device mode of operation,
>> atomic_write_max_bytes and atomic_write_unit_max should be different.
> But if the application is limited to atomic_write_unit_max sized
> IOs, and that is always less than or equal to the size of the atomic
> write boundary, why does the block layer even need to care about
> this whacky quirk of the SCSI protocol implementation?

The block layer just exposes some atomic write queue limits to the block 
device driver to be set. We tried to make the limits generic so that 
they fit the orthogonal features and wackiness of both NVMe and SCSI.

> 
> The block layer shouldn't even need to be aware that SCSI can split
> "atomic" IOs into smaller individual IOs that result in the larger
> requested IO being non-atomic. the SCSI layer should just expose
> "write with boundary" as the max atomic IO size it supports to the
> block layer.
> 
> At this point, both atomic_write_max_bytes and atomic write
> boundary size are completely irrelevant to anything in the block
> layer or above. If usrespace is limited to atomic_write_unit_max IO
> sizes and it is enforced at the ->write_iter() layer, then the block
> layer will never need to split REQ_ATOMIC bios because the entire
> stack has already stated that it guarantees atomic_write_unit_max
> bios will not get split....

Please refer to my first point on this.

> 
> In what cases does hardware that supports atomic_write_max_bytes >
> atomic_write_unit_max actually be useful?

This is only possible for SCSI. As I mentioned before, SCSI supports its 
own boundary feature, and it is very different from NVMe. For SCSI, it 
is a sub-segment which a device which split an atomic write operation.

So consider the example of the max boundary size of the SCSI device is 
8K, but max atomic length with with boundary is 256K. This would mean 
that an atomic write operation for the device supports upto 32x 8K 
segments. Each of the sub-segments may atomically complete in the 
device. So, in terms of fitting our atomic write request_queue limits 
for this device, atomic_write_max_bytes would be 256K and 
atomic_write_unit_max would be 8k.

> I can see one situation,
> and one situation only: merging adjacent small REQ_ATOMIC write
> requests into single larger IOs before issuing them to the hardware.
> 
> This is exactly the sort of optimisation the block layers should be
> doing - it fits perfectly with the SCSI "write with boundary"
> behaviour - the merged bios can be split by the hardware at the
> point where they were merged by the block layer, and everything is
> fine because the are independent IOs, not a single RWF_ATOMIC IO
> from userspace. And for NVMe, it allows IOs from small atomic write
> limits (because, say, 16kB RAID stripe unit) to be merged into
> larger atomic IOs with no penalty...

Yes, that is another scenario. FWIW, we disallow merging currently, but 
it should be possible to support it.

> 
> 
>>>>   From your review on the iomap patch, I assume that now you realise that we
>>>> are proposing a write which may include multiple application data blocks
>>>> (each limited in size to atomic_write_unit_max), and the limit in total size
>>>> of that write is atomic_write_max_bytes.
>>> I still don't get it - you haven't explained why/what an application
>>> atomic block write might be, nor why the block device should be
>>> determining the size of application data blocks, etc.  If the block
>>> device can do 128kB atomic writes, why wouldn't the device allow the
>>> application to do 128kB atomic writes if they've aligned the atomic
>>> write correctly?
>> An application block needs to be:
>> - sized at a power-of-two
>> - sized between atomic_write_unit_min and atomic_write_unit_max, inclusive
>> - naturally aligned
>>
>> Please consider that the application does not explicitly tell the kernel the
>> size of its data blocks, it's implied from the size of the write and file
>> offset. So, assuming that userspace follows the rules properly when issuing
>> a write, the kernel may deduce the application block size and ensure only
>> that each individual user data block is not split.
> That's just*gross*. The kernel has no business assuming anything
> about the data layout inside an IO request. The kernel cannot assume
> that the application uses a single IO size for atomic writes when it
> expicitly provides a range of IO sizes that the application can use.
> 
> e.g. min unit = 4kB, max unit = 128kB allows IO sizes of 4kB, 8kiB,
> 16kiB, 32kB, 64kB and 128kB. How does the kernel infer what that
> application data block size is based on a 32kB atomic write vs a
> 128kB atomic write?

 From the requirement that userspace always naturally aligns writes to 
its own block size.

If a write so happens to be sized and aligned such that it could be 16x 
4k, or 8x 8k, or 4x 16K, or 2x 32K, or 1x 64K, then the kernel will 
always assume the largest size, i.e. we will assume 64K in this example, 
and always submit a 64K atomic write operation to the device.

We're coming at this from the database perspective, which generally uses 
fixed block sizes.

> 
> The kernel can't use file offset alignment to infer application
> block size, either. e.g. a 16kB write at 128kB could be a single
> 16kB data block, it could be 2x8kB data blocks, or it could be 4x4kB
> data blocks - they all follow the rules you set above. So how does
> the kernel know that for two of these cases it is safe to split the
> IO at 8kB, and for one it isn't safe at all?

As above, the kernel assumes the largest block size which fits the 
length and alignment of the write. In doing so, it will always satisfy 
requirement to atomically write userspace data blocks.

> 
> AFAICS, there is no way the kernel can accurately derive this sort
> of information, so any assumptions that the "kernel can infer the
> application data layout" to split IOs correctly simply won't work.
> And that very important because we are talking about operations that
> provide data persistence guarantees....

What I describe is not ideal, and it would be nice for userspace to be 
able to explicitly tell the kernel its block size, as to avoid any doubt 
and catch any userspace misbehavior.

Could there be a way to do this for both block device and FS files, like 
fcntl?

> 
>> If userspace wants a guarantee of no splitting of all in its write, then it
>> may issue a write for a single userspace data block, e.g. userspace block
>> size is 16KB, then write at a file offset aligned to 16KB and a total write
>> size of 16KB will be guaranteed to be written atomically by the device.
> Exactly what has "userspace block size" got to do with the kernel
> providing a guarantee that a RWF_ATOMIC write of a 16kB buffer at
> offset 16kB will be written atomically?

Please let me know if I have not explained this well enough.

> 
>>> What happens we we get hardware that can do atomic writes at any
>>> alignment, of any size up to atomic_write_max_bytes? Because this
>>> interface defines atomic writes as "must be a multiple of 2 of
>>> atomic_write_unit_min" then hardware that can do atomic writes of
>>> any size can not be effectively utilised by this interface....
>>>
>>>> user applications should only pay attention to what we return from statx,
>>>> that being atomic_write_unit_min and atomic_write_unit_max.
>>>>
>>>> atomic_write_max_bytes and atomic_write_boundary is only relevant to the
>>>> block layer.
>>> If applications can issue an multi-atomic_write_unit_max-block
>>> writes as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO
>>> and such IO is constrainted to atomic_write_max_bytes, then
>>> atomic_write_max_bytes is most definitely relevant to user
>>> applications.
>> But we still do not guarantee that multi-atomic_write_unit_max-block writes
>> as a single, non-atomic, multi-bio RWF_ATOMIC pwritev2() IO and such IO is
>> constrained to atomic_write_max_bytes will be written atomically by the
>> device.
>>
>> Three things may happen in the kernel:
>> - we may need to split due to atomic boundary
> Block layer rejects the IO - cannot be performed atomically.

But what good is that to the user?

As far as the user is concerned, they tried to write some data and the 
kernel rejected it. They don't know why. Even worse is that there is 
nothing which they can do about it, apart from trying smaller sized 
writes, which may not suit them.

In an ideal world we would not have atomic write boundaries or discontig 
FS extents or bio limits, but that is not what we have.

> 
>> - we may need to split due to the write spanning discontig extents
> Filesystem rejects the IO - cannot be performed atomically.
> 
>> - atomic_write_max_bytes may be much larger than what we could fit in a bio,
>> so may need multiple bios
> Filesystem/blockdev rejects the IO - cannot be performed atomically.
> 
>> And maybe more which does not come to mind.
> Relevant layer rejects the IO - cannot be performed atomically.
> 
>> So I am not sure what value there is in reporting atomic_write_max_bytes to
>> the user. The description would need to be something like "we guarantee that
>> if the total write length is greater than atomic_write_max_bytes, then all
>> data will never be submitted to the device atomically. Otherwise it might
>> be".
> Exactly my point - there's a change of guarantee that the kernel
> provides userspace at that point, and hence application developers
> need to know it exists and, likely, be able to discover that
> threshold programatically.

hmmm, ok, if you think it would help the userspace programmer.

> 
> But this, to me, is a just another symptom of what I see as the
> wider issue here: trying to allow RWF_ATOMIC IO to do more than a
> *single atomic IO*.
> 
> This reeks of premature API optimisation. We should be make
> RWF_ATOMIC do one thing, and one thing only: guaranteed single
> atomic IO submission.
> 
> It doesn't matter what data userspace is trying to write atomically;
> it only matters that the kernel submits the write as a single atomic
> unit to the hardware which then guarantees that it completes the
> whole IO as a single atomic unit.
> 
> What functionality the hardware can provide is largely irrelevant
> here; it's the IO semantics that we guarantee userspace that matter.
> The kernel interface needs to have simple, well defined behaviour
> and provide clear data persistence guarantees.

ok, I'm hearing you. So we could just say to the user: the rule is that 
you are allowed to submit a power-of-2 sized write of size between 
atomic_write_unit_min and atomic_write_unit_max and it must be naturally 
aligned. Nothing else is permitted for RWF_ATOMIC.

But then for a 10M write of 8K blocks, we have userspace issuing 1280x 
pwritev2() calls, which isn’t efficient. However, if for example 
atomic_write_unit_max was 128K, the userspace app could issue 80x 
pwritv2() calls. Still, not ideal. The block layer could be merging a 
lot of those writes, but we still have overhead per pwritev2(). And 
block layer merging takes many CPU cycles also.

In our proposal, we're just giving userspace the option to write a large 
range of blocks in a single pwritev2() call, hopefully improving 
performance. Most often, we would not be getting any splitting - 
splitting should only really happen at the extremes, so it should give 
good performance. We don't have performance figures yet, though, to 
enforce this point.

> 
> Once we have that, we can optimise both the applications and the
> kernel implementation around that behaviour and guarantees. e.g.
> adjacent IO merging (either in the application or in the block
> layer), using AIO/io_uring with completion to submission ordering,
> etc.
> 
> There are many well known IO optimisation techniques that do not
> require the kernel to infer or assume the format of the data in the
> user buffers as this current API does. May the API simple and hard
> to get wrong first, then optimise from there....
> 

OK, so these could help. We need performance figures...

> 
> 
>>> We already have direct IO alignment and size constraints in statx(),
>>> so why wouldn't we just reuse those variables when the user requests
>>> atomic limits for DIO?
>>>
>>> i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
>>> constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
>>> DIO alignment requirements in those variables.....
>>>
>>> Yes, we probably need the dio max size to be added to statx for
>>> this. Historically speaking, I wanted statx to support this in the
>>> first place because that's what we were already giving userspace
>>> with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
>>> along would require a bound maximum IO size much smaller than normal
>>> DIO limits.  i.e.:
>>>
>>> struct dioattr {
>>>           __u32           d_mem;          /* data buffer memory alignment */
>>>           __u32           d_miniosz;      /* min xfer size                */
>>>           __u32           d_maxiosz;      /* max xfer size                */
>>> };
>>>
>>> where d_miniosz defined the alignment and size constraints for DIOs.
>>>
>>> If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
>>> (unit) atomic IO size and alignment in statx->dio_offset_align (as
>>> per STATX_DIOALIGN) and the maximum atomic IO size in
>>> statx->dio_max_iosize, then we don't burn up anywhere near as much
>>> space in the statx structure....
>> ok, so you are saying to unionize them, right? That would seem reasonable to
>> me.
> No, I don't recommend unionising them.

ah, ok, I assumed that we would not support asking for both 
STATX_DIOALIGN and STATX_DIOATOMIC. I should have read your proposal 
more closely.

> RWF_ATOMIC only applies to
> direct IO, so if the application ask for ATOMIC DIO limits, we put
> the atomic dio limits in the dio limits variables rather than the
> looser non-atomic dio limits......

I see. TBH, I'm not sure about this and will be let other experts comment.

Thanks,
John

