Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF484B7B65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244884AbiBOXwB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 18:52:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbiBOXv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:51:57 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C864F13CDD
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 15:51:41 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 10so648376plj.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Feb 2022 15:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOQl//KosZ4qvPRlYricOYzhur4w9CDxToybs/1HwUw=;
        b=n0fGEseKpeTJVBRLcU6aOW671FkkrGG1F12nn1nnKRlJSzRZlYdwGVuHrmkdAKwDsH
         2cgJ5x2nv5213DNiH3E5nWepZkSaeaQKiuoAqOILeyvtCV8UCAoqLCu7atcHC0pXWnJR
         x2tovGc4IH5J1oixDaAKekf3001ZtzDQDBFHrtmqFm1lHS1VVhV9AE4yNHV++T1KOkrq
         iIMPbPYw42SG+YdhpVwAMKgFAfvopVFbd2r/lUHxnzCyTokFTZHp7i43RcoioymXx936
         ywuUZN1RyKYYOnf6usErLJkp+q/V3IzojWctav49gN1CbN8yk8vRuUOmjEtrZfhnAGYx
         UYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOQl//KosZ4qvPRlYricOYzhur4w9CDxToybs/1HwUw=;
        b=jFoOYQttRUx8dJAxP4qdQD71x5RjPHGjFie9B6m5GHi3zsVDs8nleyp1XePsIcMxa8
         QY8QTZtj3SqiiVhqvZLcjjE4/iRvFV7pycvmRDbOtG9fQ9T/9n1+bWEWCXUgGkCi+VcO
         Kh1o73jCc4uS17d5porK83n1q1PsMlgnrf2ksGWcVP3VIWmtQbQsOH82TM0bzDFKvhcE
         5VOdH+Ty8lDgwq76N4q7oD6/XyUj9TuuUwb1Xa4TYiAo0Sr8XpOHxZCrKB77ei+a7qNG
         8ljLEwRZ5Alz7DqEsRBN10NOG8tJ4IY3BUvZFVgNVwO+orghdNLAemFLKxbkHaBIQoJa
         gqCw==
X-Gm-Message-State: AOAM530jVoLqqhKbCIhCoL1iCxUsmTaWaSuOGMyUnEcsCGi6QVS3U1bq
        vWpBFc9VNwoBybmOSyIbSB5eMTA6waabq3lAESJoAg==
X-Google-Smtp-Source: ABdhPJzxjD3vKy3YyT+OCGwXU78ebjUah2EKpMfMibU0VWDXa+asOUJ5+9r/BPJajQyQWY0zQRe+xjGaYgcQFwMYr/U=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr251082pll.132.1644969101356; Tue, 15
 Feb 2022 15:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
 <20220127124058.1172422-5-ruansy.fnst@fujitsu.com> <YfqBTDp0XEbExOyy@infradead.org>
In-Reply-To: <YfqBTDp0XEbExOyy@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 15 Feb 2022 15:51:35 -0800
Message-ID: <CAPcyv4jFMf_YSSgxoHJk=-0UMZeNO+PHP1sjkvXUmKfXvGaw1A@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] fsdax: fix function description
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 2, 2022 at 5:04 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Dan, can you send this to Linus for 5.17 to get it out of the queue?

Sure.
