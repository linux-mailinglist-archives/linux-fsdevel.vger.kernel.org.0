Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2EA515273
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379311AbiD2RoQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbiD2RoP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:44:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AA4939A3;
        Fri, 29 Apr 2022 10:40:56 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23THPWqR018608;
        Fri, 29 Apr 2022 17:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=elQruLpFMz7LhWmqMtTcdCRTGWsEFsHbo9YB5eMI9xY=;
 b=okjWeccT6uhgCIVbrrdzQHw6y4PPiWNU9YX0TBThar3mObTWJJBOi7RnqwLw0GfOoNFZ
 QvMXWIGKwYdA3BqL9AjWRASPOyW610NZnettg5WKTJgTSwAjGNS7QXSx4ZNwcXcLpoWu
 mWp4RLHxcM8aTgbax5zHdeGIZInBf8nB3ynQv//MQfdQZmAT0P3iJZiCpxyIRKg78NoY
 7kZu0h0S9GT9TLTG6Rt5PPU+5GTDlW9HJnfrZU7AcLGRWsEfLQfXkdfsU52AvljK5e3a
 91VaMYhAeC6TBRaN6YglHuKM1tAukCqhS3sDujUJ3U3lnL5aYYCz1bK49HAkd3heoLV5 ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k7fy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:40:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THaejZ011708;
        Fri, 29 Apr 2022 17:40:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqeesv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:40:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7E+8qfHmoikiqfGbN68w/yzYwM0bGAnhC8KXhv2oO1MElnXT3kPbPp+ZS0TuQVuhhwH7pOHLKncolSa1KQcMw5slHLrhCUfWKrYssLZ8Oxsl4+lhzMF8VKYxDk4fL1O+SycmeyXu6LBWJpNrmo542BsdgDGAfXr7WAF750dB94QeJHAWhHSW6HhyFNKRAYjm1WyopdyjyjLSQnVJl7glfVhHOPcBDPxyOWPU66TVeyKuuBrMO8+BoYEr9pApBXCcx8d/W2OURHGjvpS9lhRUlowCRzBX34N2/5oiVzYQoHsJZ9OXhph3vc21OnUbZpW0NCo0+Pxqw/Ky8yqwjbFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elQruLpFMz7LhWmqMtTcdCRTGWsEFsHbo9YB5eMI9xY=;
 b=OXtKOSZUCaA+u/ET1bW2TU/7ygcTesJDKRjEnFpvm2tly6OQ5PuX+IxfIY6JUaPpk4s9YsLbPXyMyaHcJnqA2WSEvWj1cbdhubnpKWf4VEkigkkqjKtv/1OkC/nSwbDw0/1l1Y4CHDxJPOy4ev6iMd8lIO+P82NjK43EuESfl7t5gRpPA9Un4AgXCUTZdzbJ6SFFRmQm//Z4ytmaitvwKLZZcmz7rh0iEWA9MD/0xlUW63HWpssHGmfcKq5id0vsY3fsz/I4gDZlSHre/5sNsRmKjPcWvupo4g8bzelw1rQuIsElVxIi50R0YDvtprv//tWtk7ksBw0XDXLvZ7NxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elQruLpFMz7LhWmqMtTcdCRTGWsEFsHbo9YB5eMI9xY=;
 b=gZPFT0dDjiXDdyZ/hhgoH0Rhcb4pCD8Yz+8nge62KAsrp+O5FIFRLRFJFKSBK67GNF21o9FBWLVXYaf5gVfaIediHjgLC1/eFko0Lqg1QNkWzHNgM0dG8L1cQHF6Qo/jvZSG/Wkug4q5EKtCbr402yqsUtmnbR3b8A7So8YURUA=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:40:51 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 17:40:51 +0000
Message-ID: <199e53e7-9b2e-3b9b-6c2d-01da14058903@oracle.com>
Date:   Fri, 29 Apr 2022 10:40:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v23 0/7] NFSD: Initial implementation of NFSv4
 Courteous Server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <20220429152558.GG7107@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220429152558.GG7107@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0099.namprd05.prod.outlook.com
 (2603:10b6:803:42::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30004aa4-84f0-4fe9-d17a-08da2a0766fa
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5030C4CE38D77C023E85123687FC9@BN0PR10MB5030.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oepMcDOKV+Zf7vrPdpcy9rEPwFPgTP60/OdL0bHmTZy2kobzgrTLDOEbnSJC1KnVXHrqUEydvFKE4FmOhHP4p58oPte4zmiOSD+gajhNO8zJEuZ6RwmfF6MKSXL+kx1lZMzADB/DQb/JkWEvGR6XQz4jM5fQecP1VKphWaWHf/G7wtO8TxZsYT6KRI/FM47/9iHaqvG/onbrX8pA0An5fF9C8jT/vy/qfsr1S9afOsBEeS09NHoR8V3S896OileqWgKXA3Nzhx4brhaudcdnB53dtu+gtqtJpegEB1YSjSKss63V3913+qYdPv/DihLnHXnUN2axBFkKygDkd8MyrvgcwO6xu7nrXiTjWXHdEd00TUO0GPCK0Wfd6slH635DeMn92kBK99AbQrMj48lZPKEYA+ikha0sDq0sCE/zGZxlpnBZ7vvDb+JbFHEeZwE8QjOusOH+F8UJ4BVF5eRxSEp7+rJHo5v/HW2Ek6haOOjF3rXu+h0sPFqkPGd6BNBd6aVYRUxw7cE+2mtfvREm+5V7ROH9PTcOhM3Q/c77O0FxPn51IH38VDcBgaK20sglku8FOtH1+4UbQ8oCIRJMO7EFZAi8xHa8Tx9gA+jLhtSk+xomBwkpa0qShvZ+sbLrtx1VG9W3D2SLUXBHaMJK1KJXiWn10G27UlEQ/rkSsFqBg9jC5ajRKoMWTOEFoXu5IJ32ioNFaZk5tkQwE/j8Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(31686004)(66556008)(66946007)(4326008)(8676002)(316002)(66476007)(36756003)(6916009)(6486002)(31696002)(26005)(6506007)(6666004)(53546011)(6512007)(2906002)(9686003)(558084003)(86362001)(508600001)(186003)(8936002)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OURUWDNkQnplZXIzbDljNjczNk5PSTl0UlZ0Y1FYZHFadkpTdGZqM2E0WFpk?=
 =?utf-8?B?U1lSZkcyQk5kdnlOak1jZU42VS9ya3ppdDBBNU1LeWx2aTlXVlB6ZWxEYVBy?=
 =?utf-8?B?YmpSOHh4aStPcVBnaWhBR1paQ3JBYjhoRUdMWjlIQ0twMllYRGp0QzZxeCtI?=
 =?utf-8?B?TGxDU3E2b0hBSFJzcGVMZTUzL0YybTVFVkVZL0c0OXFoUVFjN3BFUFgwQVpl?=
 =?utf-8?B?K1NPQ1R6YkNnbXBNR2ZLWlkySUZOUlEwU09Oc2lJdEl1amRBTnBhMTBFRTlL?=
 =?utf-8?B?dXM2bm92eGZBSE1vd2lBYjhDbWhDMVpMeDU4T2JmWCs4dG9icmhaaVJBTlRx?=
 =?utf-8?B?UGo5NTVBamxIcTl0dkZLdHhtTE5QWDRGQlJFV2NIaDZOVFFaaWdJZ1NRai9z?=
 =?utf-8?B?bU83QU9XVTl4cjdPeTN2ZmdKejFLbW1oT0hxcCtyTUpadG5CbXplL3BrcENE?=
 =?utf-8?B?ZTRtZUw5V1NDeEJoMUtkMHlrRTd3b2lpSnJUZnlBbHhOSUcvc1h4Wk1MMzNy?=
 =?utf-8?B?dzlkbExoWlJPNEdEN2o2Rk53MGpsc29Wb1BVSno2S2NSZC9STFNEaEVCMHQ1?=
 =?utf-8?B?YjJTZTFXS0xxSTV3TEEwL05ZTlI3QmQ3ZDgyTVdmWTN2L29Nelg4TE9hTmpw?=
 =?utf-8?B?dVJSaGgxV2RhNVFXdExJcXVjQmQvSUVHN2o5b2RTNDA5SkZaTVhlWFdtZU04?=
 =?utf-8?B?akI4eEpBZThLaG9ZRFZxZ2dzMHlXSU5BWndwYm9FTTlyeDhkb1BFTElib2o5?=
 =?utf-8?B?VUtjeWx6dXZsWlk2K0lBUmtkUk1BM01kMTEyK0hDVlF4M0EyMDRSUXpSNE9C?=
 =?utf-8?B?L0RYejdCZWs3Tm5aNWNoNTFUcUttTEIvMDZNOCtpYnZDcVR5OWZnSHN5bll4?=
 =?utf-8?B?eVdFS0VPcWFhMjhLZGp4ZEpPYVlFWXN2VmhVM0VsOXNJbDA5MDRZa1ZubjRw?=
 =?utf-8?B?OGxNaDI2UVcxcGJXS3dXY1oyMDUrY21UYUJDUGd1dUxYUGQ4QWpLTllSR1pn?=
 =?utf-8?B?Vm1naHpNWFJlTmhPbkVKRGhuM0xyb1EyV1FlNHQ4MXlzYktaUmRZaWtiUmpt?=
 =?utf-8?B?dzZkQzBPRmZkZklxOTZON3oxc0tJOUx0ZHgxaW85c3UzM3JpdUR5cGR2aU1L?=
 =?utf-8?B?bXFGN3lsTHczTnVCVVhNWkpzTFZDU2dJMmJZd2N0RWpiR3RCZ21DVDNvQlhy?=
 =?utf-8?B?aS9kNmZNWS8xLzM5VkJVeGRjMUpva0Y5MkxoS3NQNW5WaTRxRmJiQTZZRTBN?=
 =?utf-8?B?Q3AzWWJzaFBJbVlGVFRTV2czUXFQSzIyc1dsbXFHRkhCMS9HZU4wMzg3dHZX?=
 =?utf-8?B?TTJtZUF4NWdOWGc0YzBzK2xQekxIQ2FEdThhNnJyOFlzbGpLcTZFb0VxYXo3?=
 =?utf-8?B?TGZWbUxVZlJlcFhaTnF1N0MvR3BmcnF0RzZtNENVWmZuSzYyR21WSThYTUpm?=
 =?utf-8?B?emZCQmVSOTJXMkltSmZtYStSWnhZbjE4Q1lDVEdsKzhXL1JJb0FqVE54K2xH?=
 =?utf-8?B?emZyYzBPdkNOU3BsLzBsT055NU1hVXZJTTJ1UFkyUjFUb2x5cXZLcWg3cUxx?=
 =?utf-8?B?ZnRIMzc1MVV3YjhCNHMrM1VRQU9QTk56alowZ2kxY1ZsTXpBYkN5WXF2Sjdm?=
 =?utf-8?B?dWJ3OFpKSStNejdOWGMyOVBaMG1Nc21yUE55Y3ZMcHByL1p4OHNlV2lGeHJN?=
 =?utf-8?B?ZEdyeEJRTXcyV1hsV0tsYjVWb0Z6UUN0Mit3SXVOS0hTdGwvQlkxVWc5UDYy?=
 =?utf-8?B?L1c2L1hxMlViQXRBUzVqc1V6QXJCSlpFb2VXT2JYeEUyQXNlS0NWZDdFQk12?=
 =?utf-8?B?Q1kvOHU4UmovQnZmVUlWWmhrVjM3aE5Gd1FUL3BOQ0ZONFBKSjQ2OFhYWm5I?=
 =?utf-8?B?WkhRTnJiRUlYb0hLVVk5OTA3NTRsMEpIRXZRaC9DN0hiSVFWUVQ5VVk5aW5p?=
 =?utf-8?B?eWs4Z0Z1aDVCZ285V1hsNXl3L09BZ3dyTXJmMDJCTE5iUHcybU9DSDhCcDZr?=
 =?utf-8?B?b1pPRTBmQW5VMWJ5ZWtjR1BIWUJtTGJMUGhYVGhiZUVpMW5tL2JyNndIYnl0?=
 =?utf-8?B?QjNsMjVpWTRDc1pYM1JUVmxabDF1TDA1dFA0SWlvL0tlSitNWVJ6MjJZc1Jt?=
 =?utf-8?B?R0VnUE1oVTVzYmxqWWdCMEZmcFl4QnhmdDA3Rm5aQjZ3WEt5UklUeFNpOUZt?=
 =?utf-8?B?ZnE5RkFYVE5oUWh4UGFLQjZoSTZWQ1hiRVJac3c4c1lvdTAxQ29laUlWS2w4?=
 =?utf-8?B?OHQzaDFoMEw1YzlJQ2tRMm03amhHWVdRcHQ5RGIvRU1RTGU0c3QzUGR4K0ZR?=
 =?utf-8?B?U0FGZWpkSUhSNTNFQ3lYWFhidk5wUmtzZUF0cUI3QjBOb1ZuODNGUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30004aa4-84f0-4fe9-d17a-08da2a0766fa
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:40:50.9384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SI+l9gXKgH8sKaGUqsTtGzKogXeJ6mU4BkNF2mabYiroDysEB9capwaSaXa2eu8kLX07Qdj7LC/GpYgpU4PY6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5030
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290088
X-Proofpoint-GUID: WOiiXaWzT5e1s-f4VQP207OWqh8GYje1
X-Proofpoint-ORIG-GUID: WOiiXaWzT5e1s-f4VQP207OWqh8GYje1
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 8:25 AM, J. Bruce Fields wrote:
> Except for comments on particular patches, this looks ready as far as
> I'm concerned.

Thank you very much Bruce for your diligent review and valuable
suggestions. I will address the remaining issues in v24.

-Dai

>
> --b.
