Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1E84FB6AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344016AbiDKJCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 05:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiDKJCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:02:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567BA286C8;
        Mon, 11 Apr 2022 02:00:08 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23B8Bcn7031098;
        Mon, 11 Apr 2022 08:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DjsrJjeJ8PHIWKaYX2vmwZHvDlbQvCEm9gFHkKk8TzU=;
 b=Tj8DOsKzr7OcwPkmDy/gVtIhuFcMwLPimdeKWYf+GM+d8Sn13yMb37ydeDGO5CxwazXH
 TuFIRzDcF+bp801ir3l4wtbk3TsWt6W6EdqWFmkz2OyYx6dl8B1iST+avN1aZXvlkfEG
 hG3yKrnrNq1yAtkKNuABQL5OxXSSc4uOC6jJeEgiVONocoQ9cyeoU7ujbrMszoXflTNK
 o+SxrOg5po5lzt4eAF9c4VzJBFUtvCM7ujXAoQGYBOhxCxwQDrJyYo6QiP5ZFZLgddZH
 tQxibRM47OOONHtajRZZ3Cu4HjAaEoUlH4gVHge/FMqEd2WnbBV1Zz0OVF+EyhxYFLqk vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fcgknruya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:59:46 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23B8xkxr007655;
        Mon, 11 Apr 2022 08:59:46 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fcgknruxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:59:46 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23B8vW1r012240;
        Mon, 11 Apr 2022 08:59:44 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3fb1dj2sen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Apr 2022 08:59:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23B8lETk42729854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 08:47:14 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86C81AE04D;
        Mon, 11 Apr 2022 08:59:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20497AE045;
        Mon, 11 Apr 2022 08:59:41 +0000 (GMT)
Received: from osiris (unknown [9.145.53.187])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 11 Apr 2022 08:59:41 +0000 (GMT)
Date:   Mon, 11 Apr 2022 10:59:39 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        hch@lst.de, yangtiezhu@loongson.cn, amit.kachhap@arm.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 RESEND 0/3] Convert vmcore to use an iov_iter
Message-ID: <YlPt+3R63XYP22um@osiris>
References: <20220408090636.560886-1-bhe@redhat.com>
 <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk//TCkucXiVD3s0@MiWiFi-R3L-srv>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UwAkwTCwA_DPTuZqkd-6Xyzh1WuIQ_Du
X-Proofpoint-GUID: PT7yF1MGQ2mrCaJ_IUd3C1QfRpgQV42P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-11_03,2022-04-08_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 clxscore=1011 mlxlogscore=758
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 08, 2022 at 05:24:28PM +0800, Baoquan He wrote:
> Add Heiko to CC.
> 
> On 04/08/22 at 05:06pm, Baoquan He wrote:
> > Copy the description of v3 cover letter from Willy:
> > ===
> > For some reason several people have been sending bad patches to fix
> > compiler warnings in vmcore recently.  Here's how it should be done.
> > Compile-tested only on x86.  As noted in the first patch, s390 should
> > take this conversion a bit further, but I'm not inclined to do that
> > work myself.
> 
> Forgot adding Heiko to CC again.
> 
> Hi Heiko,
> 
> Andrew worried you may miss the note, "As noted in the first patch,
> s390 should take this conversion a bit further, but I'm not inclined
> to do that work myself." written in cover letter from willy.
> 
> I told him you had already known this in v1 discussion. So add you in CC
> list as Andrew required. Adding words to explain, just in case confusion.

Thanks for letting me know again. I'm still aware of this, but would
appreciate if I could be added to cc in the first patch of this
series, so I get notified when Andrew sends this Linus.

Thanks a lot!
