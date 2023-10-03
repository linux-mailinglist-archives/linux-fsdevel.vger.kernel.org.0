Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715277B661E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 12:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239863AbjJCKOl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 06:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbjJCKOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:14:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E88BB;
        Tue,  3 Oct 2023 03:14:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3932B6r5017925;
        Tue, 3 Oct 2023 10:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CFhyrb1leHz+UrwkMKuctMSLCNEQeiEwAUTlWDoWsX4=;
 b=N5zAB9vGJmtY5Xibc0QKSZCHizctEc5ZkE3yLQCKtSdJzZJnj1ZxdbfFqCY7z0+DXolQ
 xprooMGYrAMT1s1pO9g//u5JHtzpa89a8Qf2Rqbf5bhi0D/q414O2jSnKETNeRTU7y5z
 WMvoqyJKc1IWR+Q51vVoWpC6kYUCqtHWP+7vmBtCor8XU7jZUEo4qId0N9dkyd+h1Zsb
 paOqNvvXqF2rDMPXhowVZePYB03LOrezmjROS9R0uBepOIcgc5kJRkjG4lSJtXwGVWp2
 xbDuzpc5DTaGgAycvBBW4/yBR7Mdxz8U7MnNf4S5j9EqDGLdD7fGYoH2/AR4I1vhCCqL Tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teb9ucb53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:14:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393ABDaj025857;
        Tue, 3 Oct 2023 10:14:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4c5wa1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 10:14:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BohvSnGxCAqtJs0KO3zVOZoPM7dJ/OEMikIzAWZe1ne5DWLMNw/m0Uaf87W70CgNtyarSB0wgKvkFj6ENHZ29HuLp2hU6FXL2LDQ7mdwlHn5CkQZwwsZxSPAOweXPA6FEshahpow2jm5vK+XgmJ8R8Xnd3hXXyaZw6x3zCkQiKGdFx5+qmtajSlc78uIbBtLdJqTN4aXtnhKskatDeLjKkMMZx5lpYRrMB9GbSHxe/U3b4h+XgsjZiksnUYRc0KVEygKJe8dVU7OD7g1EIXIZCwCdEkJzQ6XW9iqaZwK/0lSjzOEtxK+u0ekkls/HOcC7GtpdcEv7xVCh3b0Xg1a0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFhyrb1leHz+UrwkMKuctMSLCNEQeiEwAUTlWDoWsX4=;
 b=MNNgNsSRTvYEKI5N/mZPw1mxhBNUmT1JyB8x0A8Kgsl2Y5k3vmQGdJfotv5uHacFYmRFdF6pboXc/w8fIs0/vWR1C8fsrtdjKUXUjg2ed1NafYZfPC3/3wh9aZbR8pRW2LWv7UM54wv1Ml/mpWHeSh2Ol7yJT4hlXG1FXHdH6vm+LM10poKLy3M02UqvYUfI441+kKC7dcq9SJTKE3DAa4DjVjEk0XkpcnimcbGrfP/qqAQdnRPtM6ljorvV7x85S+KQ20CMv7M9Pve+xGWKVMknS+JsQd+XiUla/CjxdU0knT1S9ugrkJJK24uxb8VmCmZyNZS3tYjUNviH+GBBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFhyrb1leHz+UrwkMKuctMSLCNEQeiEwAUTlWDoWsX4=;
 b=g38itsHRaLKXNSN4SH2i84JQzv1lRViKPlj5xjDkTXIchvGowg8uZ6R7auy7MOgyhAa1RxQYqCEyjn3oRMLWLFreycp3616D87lsHrhjoZ+91ZIOQeBN0tG57+MM5sMzbRkitDpLxjqhMZhEeg1cmDY0QWOouBXvuDsfsgNbXFc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB7937.namprd10.prod.outlook.com (2603:10b6:408:21c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Tue, 3 Oct
 2023 10:13:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 10:13:59 +0000
Message-ID: <df3e2185-6b0d-65ed-af04-9328bb2976bd@oracle.com>
Date:   Tue, 3 Oct 2023 11:13:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 13/21] fs: xfs: Make file data allocations observe the
 'forcealign' flag
To:     Dave Chinner <david@fromorbit.com>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-14-john.g.garry@oracle.com>
 <ZRtxnc7LpOlxZnON@dread.disaster.area>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZRtxnc7LpOlxZnON@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0036.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::24)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f384251-42d4-4436-b225-08dbc3f97561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WfIwY2b+I++s9madmFIVhPn96Bif6w3Q+2zHMYyAf9SBwCdajlpeLpiBI58RERCz6iWm2v5n0FQBxBCD3G43AyOjibqgnp24RgjOs5HDhLAXekN+MfqcL/gIIspFm2QTL7OaKTXF/1LDRlbelPJrdh5I9ar5jSRfyBQWGAYafyEpJ0DCJt/S4HeNDNG4n888gO6Ndtm4TH+KHcpvVK3aPNXLWb2NGQ/8deVn/xj6ogzJpucZ97ic/CMSFzFu1l9XmCLEqs8qZZ6WrM8hV2HC6bcmXr5DnJSNRF9dnnC/Rho0TjaorReNtp02WsK/z7QJfLizbpu73DjcsPYrfMFwpJynNrJ40GCQpN5eys92FCC41WFpptirv/96+j9iTD51BMOvGBcErtInL6xUpGd6tDdP/MwjWdLa6lcZrm9ea/uK/+5dhgXDd6fKAyAAQsV7659a+mbSTMtV55HLcW9AeUh4BgmfVrEatwBiaYQmFNta8SByUAzlJsa38paQzxsQaCllq73s6H3JBSqdVvSDkEGLNuXXkU9RLbEtSVc/cYBCx9s+k3WErZAO9QayWXpGJMjDLrXtkDtYv2ILx4n+cqQ6sieeAtjXQHWBI8BYJAQ7+QE2gUzr7ykSHNCj4bilWQGLldmzCQD2FByuzfBRJwBOwM4Y8z1o/3A5IYGlFjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(38100700002)(83380400001)(6486002)(53546011)(36916002)(6506007)(478600001)(6666004)(6512007)(66476007)(41300700001)(2906002)(7416002)(316002)(66946007)(6916009)(5660300002)(66556008)(8936002)(4326008)(8676002)(36756003)(86362001)(31696002)(26005)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0pVWlB5a1VHeUIveEtnbHJrVG1ud29PRHI1N1IrODVBNE93UlJJaDJpV25o?=
 =?utf-8?B?Zzl6MnF3SGRLRDFRL0NacnA2eVVwc3FXbndiUEhDRzlIUkZmcXFqUzNjSk5B?=
 =?utf-8?B?VHJyTU1jVXhHUitFTW03MTBzOFNBQ29NTzd5YUkvUVAvc0FML3ZiSFFMdlc0?=
 =?utf-8?B?NFFscXduK0lMMnQrL1pmbGZCajNkNGpqQ05IWTJCN1ZzeFN3N1ErZmlFbmw0?=
 =?utf-8?B?UURIRGZvM3VKd0Vwa21yUHY1YllaZTdwMDR6enNmajdId1k4NGliUVpKaVNT?=
 =?utf-8?B?ZlNDNWwvZ0tpekdVNTRQQnRxQ3VGcXJpQnM2VEFPOHFrbEZNa3Z4VEllK091?=
 =?utf-8?B?eDlkOUNZTW9TT1ppVWhGaHhHT1Q2dWkzNVY4TEZTcTFnWVdnSzJJeUtjY3VJ?=
 =?utf-8?B?eUhGaThYM3l2YitBaHhQajM3bXhaV0ZJODYrd2dzVjI4YllndUdYUW1aUXo5?=
 =?utf-8?B?TjRVN0x2TDFhdTBtSGw3WmFiTTFVQkRSNFRsckVjK0dJQzVJUTJ6Sy81MXUr?=
 =?utf-8?B?YTU2K09xd0VTTVFxaTZBTTVaWkVDWEFkaDZwbGRGTjVBTDgzeG1BR1E5NUQ1?=
 =?utf-8?B?NXlTM1NBeWJNTFcxaFdpZHBSZUd1UTdEaExiMm5QZmNqWEkrdEJhTHdrYWxJ?=
 =?utf-8?B?K1lmNWsxWWJ6SCtFZXprUHRlT1dIOE9uQ2doOUc2RStqRldud0FxTGJOY21B?=
 =?utf-8?B?NDh0N3N0aXVQNVNySy95dExmQ3A3N2lQTFUyMVJTRGNPNmRsTzI2c0pzSzhY?=
 =?utf-8?B?VDQyZDZRa3VKNXNwN2JBN0hOSm9yemlwdWZ3TG1MMW1GMGUzcmtoT1l1dWpQ?=
 =?utf-8?B?ZS9wK2JsK21xMFNpRlJybklJRnN0bGZSNHEweHJyT1JJRW5haHZUMXd3dzNF?=
 =?utf-8?B?MlBLQVJlQU5ML3JucXJxUTJsYnE4cHNGOHlaMzlOZENQK2RtTnZGam4xVk5H?=
 =?utf-8?B?eGUrOXRSSjROeGxNQmpSVVRZSVM4K1E0QVl6WS80Rm5tOVVBcVpVeHVKdjdD?=
 =?utf-8?B?U0dqZ29RK2xWdm1IN0NHbFl6dmkvTEhweS9KeDBFUTk3NDNleElVdUlUT01R?=
 =?utf-8?B?NFNOenpuQlZqa3lEVWkyREdUcU9nOTU4ckhBV0dlUEQvcEFMRGphSWNhUHFS?=
 =?utf-8?B?djBZaEUxQmY5cktJdUFvdHEwQXQ0VzlySFdYRUtTWHdrS0RnTExkM2daSWJQ?=
 =?utf-8?B?em94VUhGcGdBMXhLNXV4V2NmR1hXNXl2MWVxL3c3bGZpRk9qVWxUS0QycnJD?=
 =?utf-8?B?K1RSMG03dWwxZEl6clI3RDJuSlcxclV6N2lPakpuNnJLWFRSd0NlVitadFlL?=
 =?utf-8?B?YWdsTWx3NDMvWUNLTDRPaytSWWFiVE5FUUZSWHFhQmZ6akdIOWtPRnVnRENC?=
 =?utf-8?B?UjlzRmpyOHVYMUdXTFA2czRodmRSREx4dHMyTTArSnkxUU9YK0RvRHE2T2VP?=
 =?utf-8?B?UHY4bTB0YjZ5ZGdrOFcybGZ4Qk5rclJKQ1d5cFJ0RGYwZVdKYnhsU3pyQ3pi?=
 =?utf-8?B?SHRWSkhSdUFzZW9aVUNtaFlzUHlMQWJaZUJRU1lGZG5IdC9ZaTVvSHcxVmhC?=
 =?utf-8?B?MkVmeU1hL2xlNXU3c3hacEQ1UXhiWUNnSVNtTVlHangxR1N1c2dsNE1nYU9J?=
 =?utf-8?B?ZUhOUysyY2JLalRNUGxUcmU3YWoycUhwR2hEcC9IWGpoVW9OaUdKODJRUFpj?=
 =?utf-8?B?R2pOd0dLbnBCNkZ3RTVWaC9aYTU4ZzNTRVdORStjYTlUT1BtT01Kakt4VXpa?=
 =?utf-8?B?aExPQW85TjhocFFhSW4zbEZyY0lrbnEzYU1WeVBKWnI2UnNFVFRzTWxWKzhW?=
 =?utf-8?B?SmFrYjZ6NGt5YmVEMHlQQk5yazYvSWVNOHRnZU1GOFcyZStGdUg4OWY2anBz?=
 =?utf-8?B?dDZDU1Jwb0VXd1ZoU0JGYW5mR29KY2J2aVoybnJjSVhKQU9NcFhTY0hzZlYv?=
 =?utf-8?B?NFdhZFFxMDFlUnd6cWg1RFdZNDZVNER3MmRqSjBWKzE1SDRHb0FNQU9yd3N2?=
 =?utf-8?B?MkpEYnV5bzZyc1BWNVJQUmN0NzBCSk1YR3J2TlpLM3hFZGYyRlNCWm11Tlc2?=
 =?utf-8?B?eTBoT244OWhJcC9NOGJWUUZuRm5pV1dyUG82b0g2dld4SXB4LzNMMVVzSW5Q?=
 =?utf-8?Q?ZBns29gMz6FNOSKGBeICSpmdR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TEFUVXJtdUZmZkdUK3Q4Y0VmV0hZU001cUZCRUx1YldwUGRSY05aUXFoaG5W?=
 =?utf-8?B?K3h4bzlMQmVDRTVGYW1NcWZhYkdRSzFMVGhieEtsZzc1TGZyZTU5N1hlZjFm?=
 =?utf-8?B?SmU4WEhPYkdlQjJGRUUyNWRxTWc5MWpaUmF4d1YrVFI0VFQwNXNsTWcwSUo2?=
 =?utf-8?B?WnJpWkNERlFhYWljTTNyWVdFNUg5cHlrOGk1b1VEL2VGaUtsME1ObDRmaDJx?=
 =?utf-8?B?dHo0U20xNVZFL285Q3FsOUpBU0pGQSswUi9YOEpLK3A3ektCZmNOa2lNK05u?=
 =?utf-8?B?aWVLQ01qN0hOWERQS1hQTFRhdS81Q0VCMzVuQmozelJhUTBmQnFGT2E4OFJp?=
 =?utf-8?B?Ky9OcnBmQXhpS3YxRWFaQ09FSWFrQytwaDZzeW5CL1BIdHFHc09oSVpWZ0tC?=
 =?utf-8?B?SC9jWDN6ZG13S09rc3Boa3JNblBGRHE2Y0E4cktrYmFZRDlRQ3ZFNHVsVEg0?=
 =?utf-8?B?K0tyMWo3NnVJTlhKaEtmUnVHZGx0UFBpNGhFUUxQRnUvWEl2VlhEYzlhUjRG?=
 =?utf-8?B?QmhaL1R3WXc5RUd1Mlg2TDgwNDM4VnprMjRzSHFzU2hZdFptUGwwaTNucVc3?=
 =?utf-8?B?Z1NXNjlvbXFzcGJSRmF2cFBNOFF1Yml0ZUpNdmFtaitXNytlcXQzK2Jzby8w?=
 =?utf-8?B?WEdwRUFKbkp5bVhYdzhycTY3MmZKS3RYQWFMRGJwSDlvRXRKeUtQRDV0WXdy?=
 =?utf-8?B?bG5mdGJpTVNyRVUxUVRCRnhob1g0am5qNVJGNDdLWVRDSjdWaUwzRlQxVGI1?=
 =?utf-8?B?K01aemxoWmdKdnI5VXMyUWRlWFZwaDJIdXhSRzl4ZXU3NE9oaTA2bkc2cUV6?=
 =?utf-8?B?MkM5bCtaN3kwTTBJQnkvbHc3WFArdnlNRjZVOFRaRzNicXBJbG5kWUFRWUhZ?=
 =?utf-8?B?QTU2OTBFRG1XZzJpaWZHTVhnS1dPNmQ2UDhqWWVOSHB5RkRHMWYvanVMOXAy?=
 =?utf-8?B?Z1ZUZ3ZQdStTQ3MySzZ1RnFsQVhGRXVpdlFYcGc2UHBveitjN3FDNUVzMHVB?=
 =?utf-8?B?RVl6WTZHb3dOOWMyYVJNU0ZxYk96U01TdFFPbmpLYVI0SHZ6SWFYeTJVZjc1?=
 =?utf-8?B?S042cDJKd3lDRWdQYlBlV1VONURlU1MxNkdZYkpwbnR4VlJWUDlrQWl0c3dY?=
 =?utf-8?B?aU5ZL010ODcvR2VHWS8rMGpLZ0VHRlQyNHAzMWl5T3F5THVTd0w3OFdRN2Zo?=
 =?utf-8?B?M1lCNHYvMDlyS0l5UTFZRndZWVF0N2VaYkRHcFVPNlVJOHVSdVhVUTlxL1BL?=
 =?utf-8?B?VjJVZ0hBSEhEdzM3MDFud3Avek4wVVV1Tm5GVTllU3hMcGpwMG9qTDdXeXkz?=
 =?utf-8?B?UkxRN25sQ0FvTWxuT3o0NmpSSVdpV3VUYVp6V2o2K1VwM0lNaXdYZzJBNE1U?=
 =?utf-8?B?akUxNXlLcTFLbUE4MVJwQkhTaDZpU3VSMmFZQUducDJMSlI5amd4WTcyWFIv?=
 =?utf-8?B?RzJBMFU3WXFORkRTYWhmbVNtK0FDRlYreVdDVVFwZ21OTVpNSmJ6K2x3ZFdX?=
 =?utf-8?Q?ciLL39fj4Jb6fToerjcVyc/inem?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f384251-42d4-4436-b225-08dbc3f97561
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 10:13:58.7853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6ktru5iYMu5mAou0G4Icm/Zxs5esxYq7anNcohWF3qtMnTVk6s0HurMwN0SSF8jBSCyZc0FKzRgMTTvfeQzQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7937
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_06,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030071
X-Proofpoint-ORIG-GUID: A8y0z7rxh2uJnSey6OJ3Af6JaU1V5Ud2
X-Proofpoint-GUID: A8y0z7rxh2uJnSey6OJ3Af6JaU1V5Ud2
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/10/2023 02:42, Dave Chinner wrote:
> On Fri, Sep 29, 2023 at 10:27:18AM +0000, John Garry wrote:
>> From: "Darrick J. Wong" <djwong@kernel.org>
>>
>> The existing extsize hint code already did the work of expanding file
>> range mapping requests so that the range is aligned to the hint value.
>> Now add the code we need to guarantee that the space allocations are
>> also always aligned.
>>
>> XXX: still need to check all this with reflink
>>
>> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
>> Co-developed-by: John Garry <john.g.garry@oracle.com>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/libxfs/xfs_bmap.c | 22 +++++++++++++++++-----
>>   fs/xfs/xfs_iomap.c       |  4 +++-
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
>> index 328134c22104..6c864dc0a6ff 100644
>> --- a/fs/xfs/libxfs/xfs_bmap.c
>> +++ b/fs/xfs/libxfs/xfs_bmap.c
>> @@ -3328,6 +3328,19 @@ xfs_bmap_compute_alignments(
>>   		align = xfs_get_cowextsz_hint(ap->ip);
>>   	else if (ap->datatype & XFS_ALLOC_USERDATA)
>>   		align = xfs_get_extsz_hint(ap->ip);
>> +
>> +	/*
>> +	 * xfs_get_cowextsz_hint() returns extsz_hint for when forcealign is
>> +	 * set as forcealign and cowextsz_hint are mutually exclusive
>> +	 */
>> +	if (xfs_inode_forcealign(ap->ip) && align) {
>> +		args->alignment = align;
>> +		if (stripe_align % align)
>> +			stripe_align = align;
>> +	} else {
>> +		args->alignment = 1;
>> +	}
> 
> This smells wrong.
> 
> If a filesystem has a stripe unit set (hence stripe_align is
> non-zero) then any IO that crosses stripe unit boundaries will not
> be atomic - they will require multiple IOs to different devices.
> 
> Hence if the filesystem has a stripe unit set, then all forced
> alignment hints for atomic IO *must* be an exact integer divider
> of the stripe unit. hence when an atomic IO bundle is aligned, the
> atomic boundaries within the bundle always fall on a stripe unit
> boundary and never cross devices.
> 
> IOWs, for a striped filesystem, the maximum size/alignment for a
> single atomic IO unit is the stripe unit.
> 

ok, when I added this I was looking at being robust against wacky 
scenarios when that is not true, like forcealign = stripe alignment * 2.

Please note that this forcealign feature is being added with the view 
that it can be useful for other scenarios, and not just atomic writes.

> This should be enforced when the forced align flag is set on the
> inode (i.e. from the ioctl)

ok, fine.

> 
> 
>> +
>>   	if (align) {
>>   		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
>>   					ap->eof, 0, ap->conv, &ap->offset,
>> @@ -3423,7 +3436,6 @@ xfs_bmap_exact_minlen_extent_alloc(
>>   	args.minlen = args.maxlen = ap->minlen;
>>   	args.total = ap->total;
>>   
>> -	args.alignment = 1;
>>   	args.minalignslop = 0;
>>   
>>   	args.minleft = ap->minleft;
>> @@ -3469,6 +3481,7 @@ xfs_bmap_btalloc_at_eof(
>>   {
>>   	struct xfs_mount	*mp = args->mp;
>>   	struct xfs_perag	*caller_pag = args->pag;
>> +	int			orig_alignment = args->alignment;
>>   	int			error;
>>   
>>   	/*
>> @@ -3543,10 +3556,10 @@ xfs_bmap_btalloc_at_eof(
>>   
>>   	/*
>>   	 * Allocation failed, so turn return the allocation args to their
>> -	 * original non-aligned state so the caller can proceed on allocation
>> -	 * failure as if this function was never called.
>> +	 * original state so the caller can proceed on allocation failure as
>> +	 * if this function was never called.
>>   	 */
>> -	args->alignment = 1;
>> +	args->alignment = orig_alignment;
>>   	return 0;
>>   }
> 
> Urk. Not sure that is right, it's certainly a change of behaviour.

Is it really a change in behaviour? We just restore the args->alignment 
value, which was originally always 1.

As described in the comment, above, args->alignment is temporarily set 
to the stripe align to try to align a new alloc on a stripe boundary.

> 
>> @@ -3694,7 +3707,6 @@ xfs_bmap_btalloc(
>>   		.wasdel		= ap->wasdel,
>>   		.resv		= XFS_AG_RESV_NONE,
>>   		.datatype	= ap->datatype,
>> -		.alignment	= 1,
>>   		.minalignslop	= 0,
>>   	};
>>   	xfs_fileoff_t		orig_offset;
>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>> index 18c8f168b153..70fe873951f3 100644
>> --- a/fs/xfs/xfs_iomap.c
>> +++ b/fs/xfs/xfs_iomap.c
>> @@ -181,7 +181,9 @@ xfs_eof_alignment(
>>   		 * If mounted with the "-o swalloc" option the alignment is
>>   		 * increased from the strip unit size to the stripe width.
>>   		 */
>> -		if (mp->m_swidth && xfs_has_swalloc(mp))
>> +		if (xfs_inode_forcealign(ip))
>> +			align = xfs_get_extsz_hint(ip);
>> +		else if (mp->m_swidth && xfs_has_swalloc(mp))
>>   			align = mp->m_swidth;
>>   		else if (mp->m_dalign)
>>   			align = mp->m_dalign;
> 
> Ah. Now I see. This abuses the stripe alignment code to try to
> implement this new inode allocation alignment restriction, rather
> than just making the extent size hint alignment mandatory....
> 
> Yeah, this can be done better... :)
> 
> As it is, I have been working on a series that reworks all this
> allocator code to separate out the aligned IO from the exact EOF
> allocation case to help clean this up for better perag selection
> during allocation. I think that needs to be done first before we go
> making the alignment code more intricate like this....
> 
> -Dave.

ok, fine. I think that we'll just keep this code as is until that code 
you mention appears, apart from enforcing stripe alignment % forcealign 
== 0.

Thanks,
John
