Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741BA6F7C3F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 07:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjEEFQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 01:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEEFQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 01:16:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3281FF2;
        Thu,  4 May 2023 22:16:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 344Lx76i028353;
        Fri, 5 May 2023 05:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JmgghZ7l3g0ic3O16q9veWBQmX2oJecJZWKNIfqBc8g=;
 b=W0KO2cQwYwDEpGjkk6EuiugcAarbU0JccNL2fX00Tw6tbC9L019xPS2ZNmMQUZzx5Z5b
 2BbH3PXBOGHKHnz9SzFF/lvwIubFEzQiWgpbl2AId5Idv8HKqRowgYulNzEDc+DVNoPW
 WLKD9Hv6qJkGcB6keoHV26aoi+Z5u45/Oqa3ABf5NdYcXD1ICyJorcIYpyovwxve3o1O
 Fkzvr+LWMESHtaOQLwZ5WFDWvu+rbqc7BunDulyce+9MhxA8m+uy2qFL/U+LRL+obfX2
 dJ02kMZtxpvtwjLSxa5zi82Akurw0vGExGZwVj4TTv5XFaZzY68ITeCda1GAM+zeM6Ql fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qburgby1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 05:16:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3453aXwO040442;
        Fri, 5 May 2023 05:16:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp9ffbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 05:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHcxCLI9Win93Sr8HLTLdW078AuQm7p5JHGZtR8ehirHuZrX/joJT7VuIc+qr9ZWbX1coMtXM2YOt0T9DVFbRtIygPQWXPyxQMfv7Ung+oCxNlxD0nDscuk32ij4oDA2I3798WgWDk0lx/KMAARCZCX+tpUclQHy5+M0VT1R2g5MiSiw7Cjkw0//AwIQu2vuqpU1LdBQ2iq+gTJThsueytAM2ZjIGYOhb9nL/BlfaP2f2KPqx2JcWsu1e+3aFYa2b40TctLJdLY1+byiYLi1uTF+Y6p19wnfdjoMSTpXvSRCRlfa/phYEtB3Z9rbCeXs/yvEFXDxrP50eUipwpNbvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JmgghZ7l3g0ic3O16q9veWBQmX2oJecJZWKNIfqBc8g=;
 b=BRUgF75q/8WZpWELjkPCT6O3n+sXQR1n4F/jEnRtGHpzyodm7jCJxLXElE9mEZachf2LUUyv+HbLVTIi0NbLgLmOu7Tggm9V595XCOrA0OR1FUMvU5aQGqGA69/AO4QYD3Z9FXo9YHuR98lQYIpphQhnvJaSc5Ph95CLOKe1D7CBi03/GFMnCSAsTzgVLecdHUQ7ga3GJATx16waE0QfLmuzwt8sAMT7qQ2ootKmSSVKRkmcchged6/BE54QWohXKg62hAOKpaSS6ItW2Ao9A8UNgn4hrrM3TJkR0qeqcWdIAMMTntOxRybn4YUhmL6E5O+Rpxc/veb95EUxksKBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmgghZ7l3g0ic3O16q9veWBQmX2oJecJZWKNIfqBc8g=;
 b=dAKVKHxf9iK2XDOMEB10lUGEPftAcxxPvKInjqJ3LIKzwiU4tr6BD/iAmrE1uql8JFWrtUcUgrRKk+WqxEh7TUB0ZjzeIRXJm70tMG/6oPt7Tg/i23IP4g4zmissPmFLW8Cj5nu8NWgQRRjgW4BjARPkn+LNL+p4s0o46s1qHxo=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 05:16:27 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 05:16:27 +0000
Message-ID: <b8f55fc3-80b3-be46-933a-4cfbd3c76a71@oracle.com>
Date:   Fri, 5 May 2023 13:16:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-btrfs@vger.kernel.org
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org, kernel@gpiccoli.net,
        kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
References: <20230504170708.787361-1-gpiccoli@igalia.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230504170708.787361-1-gpiccoli@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CY8PR10MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 049cbdbf-582b-45a6-8fae-08db4d27e0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRDjCiioVDKK4zUStT6ap/A2B/9vq4N91c+5wubQtFbSiaz+xUqbS0X4f3ARXGjR7iUZ3gixTw/Zbu5vXQyROsh/Q6M9D0Y70oJIVMPJt0TgFDQU4tByULq47eNAVmzaVlnU4V3IGu/qptO9oDE+DFbYGCJXHdO/06turNvJ7Lg4778RDMVy3qXr6zwJ92yT1rBQ6kdgjKh18mam34h7H5IbtvUQ3uMKidP648jvXeisyfhz+pqINTxnqvDAtugmLDIIxTJhJZbii2d4hFe+2Y0xIIRLjzCTZ8Arc5Hs2ifDhK9spxU7BEitQs2ZwRY/YzB2qC6FuNCorfkbwO/aA0DY8umKQrE2l/P108xHehpEDVvwfeauMcqlLEQHBGYTPy7ob0qnCNHevJukZFo6FfLUhNE9RF2lYq7elrQOFRD6ynAtB2l+a9HjK0SJSg6CZEw5EacwGiqkfoVb5eduE0BTOwDtaLFSO//ZnQBo8uokR6yRIrpBXKC2c/zMwGx/9q2xlSKdMnMJw5EwbQTmJfbh5C1Eu9ZF1R5ruTj6og/QGUo+47ACeGcw8RfeW7RxuzOrzJScpb5a0K2miHwoKhYJ2hRSES8fn2PoTSqZq+nyF4w0eCFUlhz43RCUivNO7/rBoJN5KGVUjQMaxnOk0aaaemzccecHZM0EPY+YBBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(38100700002)(6666004)(86362001)(478600001)(31696002)(83380400001)(2616005)(6512007)(26005)(6506007)(186003)(53546011)(36756003)(6486002)(966005)(5660300002)(8676002)(41300700001)(8936002)(2906002)(44832011)(31686004)(7416002)(4326008)(316002)(66556008)(66476007)(66946007)(17423001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEE1WFE2cWk3NnhPbU5TRE0vZXFVRCs5T3dhdDlJc2RtQWk3VWM4YWlLdGhG?=
 =?utf-8?B?YVZUNzg0ak1Wb2x0WDFyYkk3T1N2RzBZZTlkMmlSY215MXh4aXdGZTE4b1dR?=
 =?utf-8?B?Z1pvd0hHR3d0SU1rMWd6UkRWSEVsSUhENjhqdVg3QXU2c3pYVXNzcW9kVTBQ?=
 =?utf-8?B?SWlSNjJXVThSMTB1S2w0V2FkNDZ4cWlJRGdqKzVIYytkMmxGRnJFR285OEpk?=
 =?utf-8?B?TjZyY3dsUGZ0ZkdQQUNNcG51TnBHTFJEb1FRbFhvVmZPRTlFck5QQVJOR3Nt?=
 =?utf-8?B?cWxHSUdVVExCbnRicGtUV212NTZaMWtLNDM0VGw5ZXBpWndqaTRhaTRyZGIx?=
 =?utf-8?B?MjlQVzVHOWdha2ZHcGFLY3NNWWhEQ0VWcUFMQzE1cE9POUtNYWZnUXZhc0Uv?=
 =?utf-8?B?SXp5blRNRkVOSkpFRXJ5RmVla1BGeWU1bFBxb3hiY3FxVGRyRlVwK3pHdWQw?=
 =?utf-8?B?ekhIYmZ0amg0L0V6TFVwUWlPV2JLYllVdnhLMTlIMHg3am5tV0NNM0R6ZlQz?=
 =?utf-8?B?eUhDV0RHZEZsNnBpWER5Z3JxcDZCWjVOM0ZvaWRQcGI4TVNQdzQ5TEdjYkI3?=
 =?utf-8?B?aVpEZ2lqUDJoVzdFTjEzY2xpcHdWQStBQ1k0R0JUTE4yR2RqOExBdU1PNWVh?=
 =?utf-8?B?Y0dLQVo0VXVxUXlLQlova3lUWjg5UmpOdU9QNVVZV1FiMzJ2UldHTG9CM0pr?=
 =?utf-8?B?WHdiVHRUdHkzK1FqcG53c1JaT1I1cUR4Z2ZPSnlJYm9aMjB4RFVwSURKSzNy?=
 =?utf-8?B?ck1uaGtrNTJ2Q1RMOWZBUnJlWFQvQXNFQmVSelRkU01wZVEvVXVQVXdaZEg3?=
 =?utf-8?B?U1pob0dNQ2s4UUJhU1VyZzk0dG1zWDhvZDA0VjRFVTFHSERDRWphdGRNUy9a?=
 =?utf-8?B?dHdmNWJDekJ5eEhxbEI4cmR3bGN1Qlp6alpXY0lxaHdPVkk2SDc3eVBOMVkr?=
 =?utf-8?B?YnBTUW9kaWp3S2FhZFJ3RzZ6ZVh5cGh3NFI2dXV3Y2I1cG5zcTcybjJ2cVlL?=
 =?utf-8?B?S3FYdDUzcnd1aTNKZ1pGTkhubFZIYnVyamVrK3hpY1U2Y0pud3RET0hPeFFl?=
 =?utf-8?B?dGkzMVBrd3VTdzdiZk9wS0pxMTFBN2h5MWhRR2xXNkZlUkNlall2OUdIbkRR?=
 =?utf-8?B?NzU1UjZQZ0JsK3VqelF1Mk1JUVFlZWJraWdHazVWd0FTbGVST0JNVTFPTGtN?=
 =?utf-8?B?RmJBZlhQWjByMTd5dFA1eE5QdmdZWmVvakZKOER5czRwNXBGVWhvY2U2ZDJh?=
 =?utf-8?B?N0lLTjBidVUrekFVeW9oOUlZQWRKTkRlQTd3VHhucWVWcjRvMitId2RsdkF3?=
 =?utf-8?B?NHBuWTdMRVJCeUdpY2JFUkhtUTQ5T25uaThMa29LSStuYWdJM00vNjV2clVi?=
 =?utf-8?B?V1ltN0s3dFlnS0JZTDh1aEhMcTJRdG1yK282Q2NiYVNDQWMyMmxQR1Zwam9h?=
 =?utf-8?B?bUhGenhqcTlzc2FFL0ZtUjZ2cEZ1OHNJdTUvK1l4bG9ibUJqTmNMZXN3aEp6?=
 =?utf-8?B?TmpTRmF3UDFGS3k0d1lXMHZudGt2YXA4bWxEdmg0eVFwczZsMkp4d1lOWlpl?=
 =?utf-8?B?TWJkb3orcllnR2xFZDdQUVVuWjA2NTZwcmxFU0dETjdwQStoR0Ftc2Fualcv?=
 =?utf-8?B?cjgzMGhOMk5FUFF3TjUyK0xrUnFFeWFjcTVEaXNXZWVQb1dxMk1xM0FyUjFu?=
 =?utf-8?B?bXFXZ1MydVFhL3FkN21mdW5DZDJPR1lFNDAxWnpWVmthL2U2blFIL2lhYnFV?=
 =?utf-8?B?UHB5SEhWZWJYYm9GcWR1U3VJemtzWUUwckVLT0RWdzRtN3REb1VsZFRNZjAy?=
 =?utf-8?B?S0tHUkw5TkRReFJoVHovQlB3K1o5WUZEWTlYYTNQVkJySVhrdnM0Y28wd3Iz?=
 =?utf-8?B?akZLY3ZQQVI2QjZJYlVVSms4V2k0UUx0Qm15aHN1WU1Mb09ZVkNaQU1QbGYy?=
 =?utf-8?B?SnZsVk9veFpvRUowNlphRGJwNXFEcmwwQm11L3FNK1N3NHNvWXduTFVSNVFr?=
 =?utf-8?B?b2RQTnR4UmtLSnBMZG5CcjRjY3E3am9Oeks3bkxyL1lqNzZ2OTdrRUlPemFr?=
 =?utf-8?B?NkdXQVR4QjNlSGlOdEViamtua3U4WFpDUDJzSGJtUEJRdjQ1V2U0azRWdDRL?=
 =?utf-8?Q?P64zEFpCWbL5cz8Zi9BPys61G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dDcvZmJJVVBjTTBhUk40SjdZbnN5cTdNWE9IWGV2Vk9hYlY2N1FVVE5INUpR?=
 =?utf-8?B?cHVvNmNMQ1dHZ2lyZVRKVWduMk5aekR4MFpMSENVYmZ1cUprcVRocHJmUllm?=
 =?utf-8?B?NzJYZHFsMDhSTkVObE5mbVRxSjVidkhzMzZuQlhDdWd3NmhzaUdsMlpsK3lq?=
 =?utf-8?B?eHhsT2FEU0NMcmZraDRrc1ZvcU5ma3dSQ3ZLTnpPNVZFRGxNK0NYSzFJSFQr?=
 =?utf-8?B?bnloYVFxUnhkWmN0bzlaVzZZVXU4UnFQOG1vQmhKWk5nTUhzSHdsazNFOHNU?=
 =?utf-8?B?R3JsWThYMGhyTHF3RC9DUTBZNXRPRVJPZDJPQUVFZ1lrUHV2ZHFCZk9Banll?=
 =?utf-8?B?MUpuU29aYW5rTFpLYnRRMkVETHZqaHVTWXV4NjFQSUdRZXIyTXpTQWpWUWNG?=
 =?utf-8?B?L0djdThlRFZJcEt0OXJtTm1qc1hSV09laTcxKzczUm5aTjJ3czRvVnRHMVhK?=
 =?utf-8?B?c1ErWUkvNDdtY1VLNm9xaW45RGF1ODdNblJvNWx6T0FSTy9tVjh4Q01jV0h5?=
 =?utf-8?B?dzlVQnNOSVlrSm4vYzBHNmVYZjEreWtncTYzNE1hYVcxOGhMbm5vUU9sUGxH?=
 =?utf-8?B?cUlFallQb1NrZkt6cTRTQUxTTlM5OCtVU2Q4aTFYR0NVQnEyYW9rM2VoZDBN?=
 =?utf-8?B?RDZzaG4yZG1Ua0hxcG5jT1NjOE0wVExpODNTd2VSQzI1eGgrakJ5L3lsY2dF?=
 =?utf-8?B?YjJFRHlQMXhkVmIxVVpBeGNJd082dlRxY0hrcjZBaHdsWktVUXNGTFN5MkJV?=
 =?utf-8?B?dUNFWTBwcUdzY3VDVzRwNnYzb2NMcFp4QUx1aGNJeG90cWJpeUFGdnY1NWJi?=
 =?utf-8?B?R2lGVkJscjZnblRBSy9aQzZZRlRraktQVnVxZEdvaUt4enVzUUFLTSsydXdR?=
 =?utf-8?B?SnJIcWRZb2UrMkFmYysvVy90SGg4MTZoMG4vT3p0ZStHNFI5Tzh4TzlvZER4?=
 =?utf-8?B?Y2psOGNUMkZkZS8yaVNtOHZLNXZLdU04UFZGdVFaNDVma2NPS2cxN05QUUNj?=
 =?utf-8?B?L3NOaXFwOU9wQmZIelY2TVdKWDZCSkFLcGVBYWNIV1FiR0VXUlZYSEtYTXpJ?=
 =?utf-8?B?UlRXem0vZytHOTJDczRSWENFVVl5WjlTMW5pQ3N3NXhuVG5ZMmpObXR2WVJN?=
 =?utf-8?B?Wm9YUWhxbTFaU1pKTXljLy9GeDRqYXdKcWRDdUJhTGhwNWlrcDc1STRpcWpm?=
 =?utf-8?B?K0dkV0l3YlVzVHJrTnVnSEpSQ1lMSU9PbWJJb2J5R1ByNVV3VUFIMHFoL3dn?=
 =?utf-8?B?SGlvNFU1NEx0S3FmWEg2Sm5Mc3Y5Zm9nWnlpdkhyb28yeDdlS1IzRHpNVEVI?=
 =?utf-8?Q?OqN2HJlDim1Ys=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049cbdbf-582b-45a6-8fae-08db4d27e0ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 05:16:27.5069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSOvok78y0TIq7xKmNVZFW5XgJ9IzPAoN/Ty+apw9DgQvSrXWM6Bx0X3K9IAqF1VDB6jnOmd5csz6gjF2p92Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-04_15,2023-05-04_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050044
X-Proofpoint-GUID: DfvmgfYT06Q0v2SxOtNtl7W_v0wM54JS
X-Proofpoint-ORIG-GUID: DfvmgfYT06Q0v2SxOtNtl7W_v0wM54JS
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/5/23 01:07, Guilherme G. Piccoli wrote:
> Hi folks, this is an attempt of supporting same fsid mounting on btrfs.
> Currently, we cannot reliably mount same fsid filesystems even one at
> a time in btrfs, but if users want to mount them at the same time, it's
> pretty much impossible. Other filesystems like ext4 are capable of that.
> 


> The goal is to allow systems with A/B partitioning scheme (like the
> Steam Deck console or various mobile devices) to be able to hold
> the same filesystem image in both partitions; it also allows to have
> block device level check for filesystem integrity - this is used in the
> Steam Deck image installation, to check if the current read-only image
> is pristine. A bit more details are provided in the following ML thread:
> 
> https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/

Confused about your requirement: 2 identical filesystems mounted 
simultaneously or just one at a time? Latter works. Bugs were fixed.

Have you considered using the btrfs seed device feature to avoid 
sacrificing 50% capacity? Create read-only seed device as golden image, 
add writable device on top. Example:

   $ btrfstune -S1 /dev/rdonly-golden-img
   $ mount /dev/rdonly-golden-img /btrfs
   $ btrfs dev add /dev/rw-dev /btrfs
   $ mount -o remount,rw /dev/rw-dev /btrfs

To switch golden image:

   $ btrfs dev del /dev/rdonly-golden-img /btrfs
   $ umount /btrfs
   $ btrfstune -S1 /dev/rw-dev

Thanks, Anand


> The mechanism used to achieve it is based in the metadata_uuid feature,
> leveraging such code infrastructure for that. The patches are based on
> kernel 6.3 and were tested both in a virtual machine as well as in the
> Steam Deck. Comments, suggestions and overall feedback is greatly
> appreciated - thanks in advance!
> 
> Cheers,
> 
> 
> Guilherme
> 
> 
> Guilherme G. Piccoli (2):
>    btrfs: Introduce the virtual_fsid feature
>    btrfs: Add module parameter to enable non-mount scan skipping
> 
>   fs/btrfs/disk-io.c |  22 +++++++--
>   fs/btrfs/ioctl.c   |  18 ++++++++
>   fs/btrfs/super.c   |  41 ++++++++++++-----
>   fs/btrfs/super.h   |   1 +
>   fs/btrfs/volumes.c | 111 +++++++++++++++++++++++++++++++++++++++------
>   fs/btrfs/volumes.h |  11 ++++-
>   6 files changed, 174 insertions(+), 30 deletions(-)
> 

