Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CF672A34E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 21:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjFITpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 15:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFITpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:45:53 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029C53590;
        Fri,  9 Jun 2023 12:45:51 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IWDeo027587;
        Fri, 9 Jun 2023 19:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ix2vOAgX/2mlIF0HBooeT6OBq/Lkw8GeHLHdbAmr9Q0=;
 b=B/gsY3syVPQHYw9VsWSRydWfCJIyn4K11/qq77KpGNUrLnYI/StkO0yjgN3vuNx2hPS4
 qZ63XAKNCkFAeGJfc4elEySCStaVdTaWUe920iiQnRhUtCjw71IrTKWfl7R0Rb5+0khG
 MWei5FZCjinrKJP0en9i3zVUIevneCeZ7r5vq6CuJ7CLFbPqS0pMiK5MagkpmKo6U7xh
 vJBVf0c7xflhpP9n/POM8liWWiWhHRJEO4/yqz9TPgVZJ5gcmhUQbkmpBOahRhYRaa5R
 GB3S58QJiOeve3J/e9q2we5R0GO88GJZw23bXo9KA2w6Pp371pP2LB6Y61znsZ37Kv0w nA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r3nwetcbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 19:45:38 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 359JjbYU002693
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jun 2023 19:45:37 GMT
Received: from [10.110.16.202] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 9 Jun 2023
 12:45:36 -0700
Message-ID: <7ba18235-24ed-c250-e782-d9b59aa0f7ef@quicinc.com>
Date:   Fri, 9 Jun 2023 12:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
Content-Language: en-US
To:     Ariel Miculas <ariel.miculas@gmail.com>,
        "Ariel Miculas (amiculas)" <amiculas@cisco.com>
CC:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Colin Walters <walters@verbum.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230609063118.24852-1-amiculas@cisco.com>
 <20230609-feldversuch-fixieren-fa141a2d9694@brauner>
 <CH0PR11MB529981313ED5A1F815350E41CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <20230609-nachrangig-handwagen-375405d3b9f1@brauner>
 <6b90520e-c46b-4e0d-a1c5-fcbda42f8f87@betaapp.fastmail.com>
 <CH0PR11MB5299117F8EF192CA19A361ADCD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <d68eeeaf-17b7-77aa-cad5-2658e3ca2307@quicinc.com>
 <CH0PR11MB5299314EC8FB8645C90453B5CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <6896176b44d5e9675899403c88d82b1d1855311f.camel@HansenPartnership.com>
 <CH0PR11MB529969A40E91169B8CBDDB39CD51A@CH0PR11MB5299.namprd11.prod.outlook.com>
 <CAPDJoNut3-7mbAZCA1Zh4D2ZsCdrjQK5=mAX8GXj0yjVWRBQ+g@mail.gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAPDJoNut3-7mbAZCA1Zh4D2ZsCdrjQK5=mAX8GXj0yjVWRBQ+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: n1iG3McEJ9VETdyGWmBEWGKQd9_5zrmi
X-Proofpoint-ORIG-GUID: n1iG3McEJ9VETdyGWmBEWGKQd9_5zrmi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 spamscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306090165
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/9/2023 12:20 PM, Ariel Miculas wrote:
> Now if I could figure out how to disable "top posting" in gmail...
> 
> Regards,
> Ariel
> 
> On Fri, Jun 9, 2023 at 10:06 PM Ariel Miculas (amiculas)
> <amiculas@cisco.com> wrote:
>>
>> I did use git send-email for sending this patch series, but I cannot find any setting in the Outlook web client for disabling "top posting" when replying to emails:
>> https://answers.microsoft.com/en-us/outlook_com/forum/all/eliminate-top-posting/5e1e5729-30f8-41e9-84cb-fb5e81229c7c
>>
>> Regards,
>> Ariel
>>
>> ________________________________________
>> From: James Bottomley <James.Bottomley@HansenPartnership.com>
>> Sent: Friday, June 9, 2023 9:43 PM
>> To: Ariel Miculas (amiculas); Trilok Soni; Colin Walters; Christian Brauner
>> Cc: linux-fsdevel@vger.kernel.org; rust-for-linux@vger.kernel.org; linux-mm@kvack.org
>> Subject: Re: [RFC PATCH 00/80] Rust PuzzleFS filesystem driver
>>
>> On Fri, 2023-06-09 at 17:16 +0000, Ariel Miculas (amiculas) wrote:
>>> I could switch to my personal gmail, but last time Miguel Ojeda asked
>>> me to use my cisco email when I send commits signed off by
>>> amiculas@cisco.com.
>>> If this is not a hard requirement, then I could switch.
>>
>> For sending patches, you can simply use git-send-email.  All you need
>> to point it at is the outgoing email server (which should be a config
>> setting in whatever tool you are using now).  We have a (reasonably) up
>> to date document with some recommendations:
>>
>> https://www.kernel.org/doc/html/latest/process/email-clients.html
>>
>> I've successfully used evolution with an exchange server for many
>> years, but the interface isn't to everyone's taste and Mozilla
>> Thunderbird is also known to connect to it.  Basic outlook has proven
>> impossible to configure correctly (which is why it doesn't have an
>> entry).

One of the big reasons why I have quic_tsoni at quicinc dot com 
(Thunderbird/Mutt/whateveryoulike except Outlook) on top of tsoni at 
quicinc dot com (Outlook) to make sure that we comply w/ upstream
guidelines. Two email IDs are hard to manage but it gives
the good separation and freedom.

---Trilok Soni
