Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37E86EB0D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDURmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbjDURmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:42:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5815632;
        Fri, 21 Apr 2023 10:41:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33LCYmxK006750;
        Fri, 21 Apr 2023 17:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GWUj9j4b41Yz8L6hOIBHN2nfxdfGAGhr3NTRuG8UNyc=;
 b=ZdfDZZ7mttWL16S5Ip4CRAE6MTNE9eC7+5FvFI7NDmqXE2W8lOmStF5ixds9ayoMLGpy
 P0HE5tsNrqSMvnkeRbKxE8IDasWCKRu4WBQ/gDBwdXPvl9rx8XYmQkEu87XGz7WO79S4
 BwIbZYBnFUvp0RUSTViZOl56stwqrkfL+7gcEUaNIxpZZq4m6E64b0mCBag2tUxDPslG
 0fZ9WJd/f1VKvtp8NB7UnLfhEgbtwPKvC5XYtzzniVSQjLis19d5NpfYecz53CbGLcHE
 TmvadJZViHqmpN6t1Sx8HSN0bSRNznJVPYCW7okDzpGYQRC8I8rhD1rB2KtH+1ZsVchP TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pykhu5u41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 17:40:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33LHXJuu037854;
        Fri, 21 Apr 2023 17:40:50 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pyjc9wkgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Apr 2023 17:40:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/fHOPt6Rirc/qElZXac6Lehz97/+ZZNXoqy0tsu9Q2o2Tgo1BOwiXAKCqvSSNeG6XmbuIKZofcsIzjhwVAGpzAFyGoij2BaJ8K52j8iL15wC4FgYTTHpDIKnT0pKUsW0kaGLtUpLk/ekC5CPftKAMhhX1oLxrRAYGN25YA4U1MrFWBGvh9X0UE9LrhhNLOKMkyTb52t/305lFP/GtRSeOmxaC1ZMa5zuXyiuDuaXcmS5DFI6Hqc8BPREwhrlw5YueH4A81BA3Y+mFASRB5iDB8scdwU31Gvsx+p6JRcelrNIz8Qp8lxsrcZA1y+avN2SpC6+vFeq/KbvaQwsBrNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWUj9j4b41Yz8L6hOIBHN2nfxdfGAGhr3NTRuG8UNyc=;
 b=MrfF+clweGY83GP+zoqAwdSkKFNjfzSd2SsVgKWQjecyN6Pc0il4AeMfcRBbiLGxV5RmOuy+jfC6uc5MBkgbDSA6jbfTBCoZQ3B2Y1fmhzFNu5Urc0b62VT90UNNCTGX1DEjHyTqTYFvm9+9gvS35O5siHAqyd9oWpc3leZuBbqkqnCzu1yulfEmmntIVPMygP0Zvnqw6sg31pXhdbhfdSE5x6ME7ndf/r/4284qJ+oqoURcXdDQp/6jgl9fZOkodqKBeoZOydmPjhdqEZEQ/+aW9UWx/MlgcQnUC+xJftVzga3Z/gr9eK8BE4mvuWv7kTotspHZxxmXqyirLDq7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWUj9j4b41Yz8L6hOIBHN2nfxdfGAGhr3NTRuG8UNyc=;
 b=Mok9+z+wqVv8iw416Ud6rHoxoFwqikPdSDQp3hzIYLP7BD2hdsus1ANBnm27Nd52nRMkTtk6MoFXAK09ZBkcyXS9wuPJRtaYTM7B5NiQBLOSO19K5mNzvd0WY9SSMPLSoyTGQ8x0Uz8B4jOpaIzq5R2oOwE7xwNVM7Th/MiY5k0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DS7PR10MB5262.namprd10.prod.outlook.com (2603:10b6:5:3ab::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Fri, 21 Apr 2023 17:40:47 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::a870:411d:9426:21b3%10]) with mapi id 15.20.6319.022; Fri, 21 Apr
 2023 17:40:47 +0000
Message-ID: <13d484d3-d573-cd82-fff0-a35e27b8451e@oracle.com>
Date:   Fri, 21 Apr 2023 12:40:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [ext4?] [mm?] KCSAN: data-race in strscpy / strscpy (3)
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c2de99a72baaa06d31f3@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, tytso@mit.edu,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, martin.lau@linux.dev,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
References: <000000000000b9915d05f9d98bdd@google.com>
 <CACT4Y+a3J0Z2PThebH6UaUWchKLWec8qApuv1ezYGKjf67Xctg@mail.gmail.com>
 <ZEKko6U2MxfkXgs5@casper.infradead.org>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <ZEKko6U2MxfkXgs5@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:5:1f4::40) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|DS7PR10MB5262:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b673cf-9eb1-42d5-eaa1-08db428f8a34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FK+jUXscJfj6D3w3L5ruK6pZTRvLCGfEpQ8akeBwVup0toUMfwoXXWrBF+/jZwKg76puL4aHBkn8kWHFzoKBReLZKppJf+66M0esF4ymQMwUt7CGeF5rqkZ4gCTypUINxxoYYMzJgAoE0Tjo2SmWWgoaOD9HQVc0RSJdin8birvOXm4ZSzIXkVZlkt9Uuy7pn343oF+/bz1emIoRleSV3if/tujlq25xXhrMCe7cQVNTXOPTdtzn+BuO9IrosAXY5HZdeClZWx20qBvKWeXj98RGg1HGeQYCIPrWzVDceifECElGY5w68f2lQB14zKJi0TFoJn8y41sOKDPSpW5GC2P3yG3O6zP5hj5ccRJTTAoukHH3sy9GauaKk8PtGxjg0UOw82Lq1mxwDlTkBa2/U6Hzt6Ut9DoJFH7qYO2gl8tlW1/roqnKLs986dornWRjnbOK1+BuzadYekQHJ7fVYXapxU3nO+nsBxzY45tIDEWBLSU5EBa7V0tTPnbtALqjH25HcOwoBomWStHztZG8nCtHYzqGMSNDlSyjHWQwQOW840EBTslwflneUK468I4UxhyllyfboW3h+netxCxR+LQ104cMIeb/p1NlkBFekAPEut3PdTy6i62EisJw73KodNOAhgDIZhbdSNFoQPtwKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(186003)(966005)(26005)(66556008)(66476007)(316002)(4326008)(6506007)(83380400001)(53546011)(6512007)(66946007)(2616005)(31686004)(6486002)(36756003)(31696002)(86362001)(54906003)(110136005)(38100700002)(8676002)(2906002)(7416002)(5660300002)(8936002)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THMvNzFjRmJacnRkZmVVYkpacEpNZFFzUERuYmF6cXBZUWlmZW95OHhVelk5?=
 =?utf-8?B?ajFkdGxGZE12V1dVdVkzanhuMzBGY1ZCMm1kZEFMdlNXaExlN1V3aFI0ajh2?=
 =?utf-8?B?dHVqVWFrNjg5UllxV2hBMzFuV0ZvanlmSGZoK2ZFbXpMSnI0ZHhRRmhJY1VO?=
 =?utf-8?B?NWExMVpwQUMxMHYzc1NyUFF2a3NmNC9KNVZqazBSbXJDZzk4N1RCajZCa0tz?=
 =?utf-8?B?ZVhjSEFOM2d0NnRMMFpmdmlJSm1zMWhCekFQMGF4UzhCaHRBL2JVeTA2RVJT?=
 =?utf-8?B?UFllWk9TKzUraEt1aWkrTlkxdzh1bXFUVDVqd3Q4RXBGbElzc2FsNUt0cmpk?=
 =?utf-8?B?WjZIK2JBV1Q0dHBiYzhqV29qQTR5cXlvYVpwTjRKOGpFNjNNbDVrL0J4Qmpm?=
 =?utf-8?B?d1pPSXlwVzZZUlBvS3JaNlpBY1RXaFM3NDFaY2UrSFVwUDNwOHdEeTl6Mjd6?=
 =?utf-8?B?RlZURDZTalgvWHJMUkcxQnd0OCt2eWNaa002alhTWEplZ3lkQVh3Q3hzT2ND?=
 =?utf-8?B?Q3VWcU8yR1hPelFmZ3hVeUhsNkxpZnhJVFczVzNWODh6R09LMjE2RTdOUFBa?=
 =?utf-8?B?TStXeVFBeHdtY2tmZGdlVDZGd2xlb0lYR1AydWpiRTNSMzNRTXJEaFIrb3R2?=
 =?utf-8?B?R1M1R1RwSnFmZUJuTnRQYitRcnhlMElRNG05NFJBbDBCSGJ4RDM3dGpqMWZL?=
 =?utf-8?B?NFczU05rMnhKQXMyRXRMRjdEdUE2SXdnVnorejVhMldURzR3ZXk4WER4dmFU?=
 =?utf-8?B?eWc5TDIzVDJsREhTa1V4Nm5rOXlabFFyQjBZNVZqd081bzV4NTVibDVqeDE3?=
 =?utf-8?B?OUVkVWRsbHlRTURGemFJcWlxczdnQSsrcHRNcVpjelA1ZWlzanVrOUl4aVAv?=
 =?utf-8?B?eEc2NVhjalljVFZhY1kwTjlDMnpzcWhVc0ZTNUlnbStEUnd4WnZpZ1RlY0pj?=
 =?utf-8?B?eEJ5Slc0bkhrNWIyb3d1OXpUK3U0eS9weiszMzRuUnlnRkE2dlVSZ0I0TU95?=
 =?utf-8?B?dGhlY1lxMmxjWXdMTXNjcGpWMjgwczF0M044cmJhVEtXY3VUdm5YaVJDYzBQ?=
 =?utf-8?B?ck53T0FaaHF1Mm9vWDJwK0tSQmhGclBEWnlFOEFiR2x6Y29WNk4rY1VpM3Nk?=
 =?utf-8?B?eUY5TzE3eHcvbmVJQTY0N3hRSUhKTFFEdThGaEhnUUEzbmhRQU9KbFM4bDVt?=
 =?utf-8?B?eC9KRnV5ZlpJanpBUDFBWVZBUmNWMHBGY1RQTlRSaWJZVnZ6OTQyWW9GUlZJ?=
 =?utf-8?B?cW9XcnRtNGE4OHVXLytic3NKY3ZvSFdJQy9DVE5oMWlYWnBhOE9DYVRDdDIr?=
 =?utf-8?B?N3ZoTTVETnBLS25Kc3BLNjlnZmE3ejJVbVNsQzhlVWtSSUp2bjBBNFZNUGdL?=
 =?utf-8?B?UnQ0czRiRUdDZm1xa0xmUjVlUnFJSi94aW8wdGsrUnI3amNQREUwQS9Kc0pl?=
 =?utf-8?B?dUdsM0c1by9mTkRoYUNYeTd4Q1czZ20weXBDWVZidDFMQlJaRFliaVkxWVZ6?=
 =?utf-8?B?UjBHWWZsZ2gyaFhhSFNwMDNBclJNMmtaTm5ONld1alRoL2p0Y245OHczcEJq?=
 =?utf-8?B?YmwrVm9vNzlLRDJCVjlTN21nZFp4UWhFaEZrSnh1WmlRV0YyL2p2OUgzWG5t?=
 =?utf-8?B?OXlWT1Q5L2ZGWHVLRThQSEFDa3VZNzVEVGZTZVhHY2lTZi9TbUxSZ0xVVGU4?=
 =?utf-8?B?NnRtQUlhVnlqZTJadjladmJBY2thVmVickxpNlk0dTByeVZLVkJNaW16ZHQ1?=
 =?utf-8?B?QWZQMzFCRkVHQ3I5bkErV05uZzB5Q3NHVStvUXVVVmhqbVVnWGxvOEsxSXps?=
 =?utf-8?B?SGJka3czY0Z0UW4rK3RCQUY0RGtzYUVxbmRzcTZUdTVzUjRtYWJQU3VtNWVK?=
 =?utf-8?B?SVQ0YVN4NDFoRjg5Um1FT285SXg3ZHUzcW1iUDdxdUw1Z25UTllhV1orUG1C?=
 =?utf-8?B?NE5PelF1MGJ4Qm9QYVhqeW95cXpCN2RyS21LcFIxVks4Y2hhTkpndUhjRkRp?=
 =?utf-8?B?SW9Qak02UXRiajFUK0w5UUMzWFZQRVpVMlFkZEJXNUdkUU9lNlF3YmlWcFlI?=
 =?utf-8?B?NkRSWHQwYXRnOVZvKzZBY25udHNNaTlaL2VqRG9obW5EM0l0cWFOd2d6dDQw?=
 =?utf-8?B?TXlSc1NmOWw3MFpVUnBMdUViVEdmaEZiQmxZMHBidlZXMnp1VHJXWC9JMnVB?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Tmg1VTQ3V2tWSjJkKzUrcFpqWWcwL2x2R2lkNlZKUDVybmgzZDNnTVpGd053?=
 =?utf-8?B?bXIzTGh1WlJ5a2RTelBsRHRwVW4yMkk3SDd3RC9TK210TkpidEt4UHN2Skxv?=
 =?utf-8?B?SGRMM3dYTmJuVEU4Slp3TFBQRllDTmxOSlR4RHAxU1dVTEVoWU5hY2w3d2Fq?=
 =?utf-8?B?TlJZZ1pTeFRhWnIvN1cwdHZUbndmUHh4bkN2bzlWWVZRTmxHdGdzVllXRlNJ?=
 =?utf-8?B?UGFUeGxoekQwOVNnNWwxVTM5WWtkSEp4eTlZeGNxOGJXdTBITjZDYzNSRGhr?=
 =?utf-8?B?My90MTQ1bGZ4UGczd2lwd21JSUFiRUhLVFJxRVVZbVloaGwvT0ZRWjFUdW5i?=
 =?utf-8?B?UXBXVWM5V2s2UFhiNFY2N2FDbjE2Syt6RWJ4K3VlNGszU3RGWTh5ZVlUOHBE?=
 =?utf-8?B?Ym9SSzVhcDlZM05ONUQ4Mk9rTnhWU1RHL09kTTFEOXVPaGJabEtaVFFKdG9l?=
 =?utf-8?B?N3VpQnM5N1RtOW9uOUN6S1k4ekFSNi9ZTUx4OSthZ3N6VjlHdWxhREk3NDBC?=
 =?utf-8?B?ZHNDRE5jdUo0b1JObnFvOTlmek1mbnBXUEFOSkRXcUtaV1YxVzJaMWR0M2dp?=
 =?utf-8?B?YzVPTW5uUHJvU0F1YnQ1V2ZGVllEZDA5RWd6NlNDTlpVSmlWSml4dzlObjE4?=
 =?utf-8?B?RFRVcFMrMzZNa2hBNGZpYjVSRHJSZ1VIQ3hoejk3d2RHeGYyajE5ODZVMjg4?=
 =?utf-8?B?Z2VGY25IOENzRzdOd2NBNktkYU0wY0QyWmNKZ1dNQ09DOVkrZGFzWFJHWTdN?=
 =?utf-8?B?OVo2SGxNY3dkRUZSMFBtazZJNklhaDc0SHh5VENSbE51bGR1VkdGUFRqUmtL?=
 =?utf-8?B?UlUzY1dtVVdrZExmWW1IWC9TKzBMdFRwVWlqdlZXMUUxUXZ3U3Uzd1dOTmZH?=
 =?utf-8?B?NXVub1hrVlQxMlQvSnRqbVkva0ZjRGZuQ2wzSnhEYkJzVkNqSlp2MVA1NXNs?=
 =?utf-8?B?ZGhLZFBpKzEvVlNqQU1odW1RaGlWTi8vbWVNR0t4SVNINU9EbU42ZFlEcEtq?=
 =?utf-8?B?cm9BZmlyWDU2YW4wRHd1OTgxUWFzc0JCV2NxU3FsRE1ON2JLOE1GVjZjek1H?=
 =?utf-8?B?cWR1a2hXQ0IxTitMMjdLalZ2RHZlSDZoNkNqcnU4dXJTenprSWcrTE9JNGk1?=
 =?utf-8?B?NVkwM0Uvbm1LRFpLOTZpTEhxOVJOakZqcVhxa1ZTQnowbmlNUFBrUGV4STFl?=
 =?utf-8?B?VzRVd2lWaGhBOU15UkpFaTdydUU0VElOaHFLWFNWZGhsSHNmU3VmS1Q1VVhN?=
 =?utf-8?B?TUVyTVhXeERwcGp4dW1Ma1RQS2l1dlZ4TEdWS0lhUlhKMHc0MmRaUTh3dlZu?=
 =?utf-8?B?YXZOR2g4YjBGT3BINmY1WHA3RzBEWXhjTUkwcWtHOFRZR21leFQyaURNZHNG?=
 =?utf-8?B?ZUUyVG9kanl5V3hjV0gxTHoydXdZVnkwNkxyeS96YmpBVktYUDdaSTNKbWtw?=
 =?utf-8?B?REt0MHhEQ1B6VS9TUVZEN0NOQ0Frei9BbVltQnNOTUQ2K2pqNjdYUjlSU2ZQ?=
 =?utf-8?B?dmh4Y3JjUTlqbklpWnJxRWs4aGRxY3VaQ2FmMGRMM1I1TjBGUW44anRmY3Fs?=
 =?utf-8?Q?TeJNYw6UO4OiNgH/51SWw41qw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b673cf-9eb1-42d5-eaa1-08db428f8a34
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 17:40:47.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOvZ4eAPfZUFVA8IZu7t8lcvAL8EtzDM5P2JRoc6nvwVeWWUlv/6Z86tTULNtve2vck4QF2CXMD2XUk8iTIWNywk2Q9od3zXdRBoUIGavWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5262
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-21_08,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304210155
X-Proofpoint-GUID: uT_IzaZacyISFsB7lsNVOPLxPHy9umH4
X-Proofpoint-ORIG-GUID: uT_IzaZacyISFsB7lsNVOPLxPHy9umH4
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cc'ing Christian, because I might have fixed this with a patch in
his tree.

On 4/21/23 9:58 AM, Matthew Wilcox wrote:
> I'm not sure how it is that bpf is able to see the task before comm is
> initialised; that seems to be the real race here, that comm is not set
> before the kthread is a schedulable entity?  Adding the scheduler people.
> 
>>> ==================================================================
>>> BUG: KCSAN: data-race in strscpy / strscpy
>>>
>>> write to 0xffff88812ed8b730 of 8 bytes by task 16157 on cpu 1:
>>>  strscpy+0xa9/0x170 lib/string.c:165
>>>  strscpy_pad+0x27/0x80 lib/string_helpers.c:835
>>>  __set_task_comm+0x46/0x140 fs/exec.c:1232
>>>  set_task_comm include/linux/sched.h:1984 [inline]
>>>  __kthread_create_on_node+0x2b2/0x320 kernel/kthread.c:474
>>>  kthread_create_on_node+0x8a/0xb0 kernel/kthread.c:512
>>>  ext4_run_lazyinit_thread fs/ext4/super.c:3848 [inline]
>>>  ext4_register_li_request+0x407/0x650 fs/ext4/super.c:3983
>>>  __ext4_fill_super fs/ext4/super.c:5480 [inline]
>>>  ext4_fill_super+0x3f4a/0x43f0 fs/ext4/super.c:5637
>>>  get_tree_bdev+0x2b1/0x3a0 fs/super.c:1303
>>>  ext4_get_tree+0x1c/0x20 fs/ext4/super.c:5668
>>>  vfs_get_tree+0x51/0x190 fs/super.c:1510
>>>  do_new_mount+0x200/0x650 fs/namespace.c:3042
>>>  path_mount+0x498/0xb40 fs/namespace.c:3372
>>>  do_mount fs/namespace.c:3385 [inline]
>>>  __do_sys_mount fs/namespace.c:3594 [inline]
>>>  __se_sys_mount+0x27f/0x2d0 fs/namespace.c:3571
>>>  __x64_sys_mount+0x67/0x80 fs/namespace.c:3571
>>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>> read to 0xffff88812ed8b733 of 1 bytes by task 16161 on cpu 0:
>>>  strscpy+0xde/0x170 lib/string.c:174
>>>  ____bpf_get_current_comm kernel/bpf/helpers.c:260 [inline]
>>>  bpf_get_current_comm+0x45/0x70 kernel/bpf/helpers.c:252
>>>  ___bpf_prog_run+0x281/0x3050 kernel/bpf/core.c:1822
>>>  __bpf_prog_run32+0x74/0xa0 kernel/bpf/core.c:2043
>>>  bpf_dispatcher_nop_func include/linux/bpf.h:1124 [inline]
>>>  __bpf_prog_run include/linux/filter.h:601 [inline]
>>>  bpf_prog_run include/linux/filter.h:608 [inline]
>>>  __bpf_trace_run kernel/trace/bpf_trace.c:2263 [inline]
>>>  bpf_trace_run4+0x9f/0x140 kernel/trace/bpf_trace.c:2304
>>>  __traceiter_sched_switch+0x3a/0x50 include/trace/events/sched.h:222
>>>  trace_sched_switch include/trace/events/sched.h:222 [inline]
>>>  __schedule+0x7e7/0x8e0 kernel/sched/core.c:6622
>>>  schedule+0x51/0x80 kernel/sched/core.c:6701
>>>  schedule_preempt_disabled+0x10/0x20 kernel/sched/core.c:6760
>>>  kthread+0x11c/0x1e0 kernel/kthread.c:369
>>>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>>>


I didn't see the beginning of this thread and I think the part of the
sysbot report that lists the patches/trees being used got cut off so
I'm not 100% sure what's in the kernel.

In Linus's current tree we do set_task_comm in __kthread_create_on_node
after waiting on the kthread_create_info completion which is completed by
threadd(). At this time, kthread() has already done the complete() on the
kthread_create_info completion and started to run the threadfn function and
that could be running. So we can hit the race that way.


In linux next, from 
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=kernel.user_worker
we have:

commit cf587db2ee0261c74d04f61f39783db88a0b65e4
Author: Mike Christie <michael.christie@oracle.com>
Date:   Fri Mar 10 16:03:23 2023 -0600

    kernel: Allow a kernel thread's name to be set in copy_process

and so now copy_process() sets the name before the taskfn is started, so we
shouldn't hit any races like above.
