Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A404822B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 09:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhLaIOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 03:14:01 -0500
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74]:2486 "EHLO
        mx0a-00364e01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229667AbhLaIOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 03:14:00 -0500
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BV7NgOA003664
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=pps01; bh=Rm78HBTRjr3KyljYvcBe60SoZ5YouaTi80klyG/rsYU=;
 b=DnzAg9Q9856ScrBE1HJi1fdqQ+h1tutMIQ6hwHozGnTljlulpU+O01vf0WL69mGTZkLv
 ME4wqbGajJ/a0Yq039hms3iXHY9xT9NrL1D4sadG1i00rAJuGybvG6D2h4xAmNuFHNpf
 vYSour7CmVedy2glJPvA4UYn4V9wS+mlOkBghDqCeYAKMeSgqGU2D/bzubsbakJSBjSm
 OM3GUVWxZki03nAT2GYsdL2alhNCmUaGZv4ruDD3HKhLCvF3pTMBxhjuZgf9NrBzIeaZ
 9zEyanSeBB7ArUByZ5isgFDjlGrtTiV4nzsCbUyoGxBRu4QrwSCMFPZ0Qt2xRRwQEvkB lA== 
Received: from sendprdmail21.cc.columbia.edu (sendprdmail21.cc.columbia.edu [128.59.72.23])
        by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3d9u4k8ck7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:23:42 -0500
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
        by sendprdmail21.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 1BV7Nfv5129881
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 02:23:41 -0500
Received: by mail-ua1-f72.google.com with SMTP id g28-20020ab016dc000000b002fb2c2eb14aso10420901uaf.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Dec 2021 23:23:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rm78HBTRjr3KyljYvcBe60SoZ5YouaTi80klyG/rsYU=;
        b=Rl9k54rbVqgs4S0x6A8roHVQ5NFUxfpkqshcX65JGzB7Ug8kTNRPVv3jPPyF0812re
         VqLWVyoNvMM0DyeVkBHzR8xzISLa3XePxF0C4U6E7wQr0i3Rs97ACGvPZqwo0oicSuY7
         y3jQmGaydZjVeflt4cOOGoKRv0XpnVnS4mTLlJ21AXMSM8vv7pFFazY49m64MZuggmav
         GEGI94a3hf6tL3vWhfZC94Q/vL2zLI0wbgZLxEKNUk640rAz9YjNsA3fWc+wVYnU/l7d
         LL+0HfQhTyEty2ReXVylnHKKZ/cnvMfxqiD29EHFNPnoRgyGimDb9GOYJVYEQMRJ5m6V
         Dj4A==
X-Gm-Message-State: AOAM531124DaL7+aAEtrVvKXC5ywpLIIKnorI28Q9aMn6cMMrRUw4Mg1
        ejvZdVMPG0u83++gi3ZR+8zxu4OFgD+KdgxUZHHAe4anRtuGomBal9EM5Su0KT5nvc0uVnaXhSu
        ILmH+3ldKP2hfubk7V7/bJth/ZTLXxP0p5AYaRrYRUwePH9kXQg==
X-Received: by 2002:ab0:6c56:: with SMTP id q22mr6428418uas.118.1640935420782;
        Thu, 30 Dec 2021 23:23:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyratuPwQUBENdFA98O6mJAp7VJyCeTO9uxdr8YefBPe/zJbSBXSAY+IT5uaHdbAUIu/IiGn+IgRMkhyhXt/4=
X-Received: by 2002:ab0:6c56:: with SMTP id q22mr6428415uas.118.1640935420627;
 Thu, 30 Dec 2021 23:23:40 -0800 (PST)
MIME-Version: 1.0
References: <CAMqPytVSCD+6ER+uXa-SrXQCpY-U-34G1jWmprR1Zgag+wBqTA@mail.gmail.com>
 <Yc4Czk5A+p5p2Y4W@mit.edu> <Yc4RWoKfLFjwyG01@zeniv-ca.linux.org.uk>
In-Reply-To: <Yc4RWoKfLFjwyG01@zeniv-ca.linux.org.uk>
From:   Tal Zussman <tz2294@columbia.edu>
Date:   Fri, 31 Dec 2021 02:23:29 -0500
Message-ID: <CAKha_sooUPSJMeRBvB=OeRL3NRc9a0rKPDQqN32XJPP+Y2bocA@mail.gmail.com>
Subject: Re: Question about `generic_write_checks()` FIXME comment
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Hans Montero <hjm2133@columbia.edu>,
        linux-fsdevel@vger.kernel.org, Xijiao Li <xl2950@columbia.edu>,
        OS-TA <cucs4118-tas@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: ul42DmQ3UggJOyPZS_K8TExs_4dCX5pk
X-Proofpoint-GUID: ul42DmQ3UggJOyPZS_K8TExs_4dCX5pk
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-31_02,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=10
 mlxlogscore=368 lowpriorityscore=10 suspectscore=0 phishscore=0
 bulkscore=10 priorityscore=1501 mlxscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112310033
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks so much for the detailed responses! That makes a lot of sense.
We'll send out a patch removing the comment soon.

Thanks,
Tal
