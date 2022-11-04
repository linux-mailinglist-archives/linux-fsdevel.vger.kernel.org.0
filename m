Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9661A025
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKDSjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiKDSjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:39:01 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A30101EF
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:39:00 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id g10so6039691oif.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Nov 2022 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/eaHXmf2PauUwbh2A2MPaTE0oM/kMlZ6+C9nCeVhgAw=;
        b=FyjO4GDxglnTZnbVJEnTCkM+ad0b9tWkBlCHI7YLLDoBs/T8qFEQJKEEU06ltOCbr6
         NblIeD8IQYWUjWFcpKC7EWaF48cB0iyIpio+/1g1lIXMDJYh0wN6taWvLZkLeOeHdSeJ
         VQ1qQ3Nlb2uZAvc966/fN/XQAFDLSTqZbDrv2TxWY8Y9MuUsRo3HsnbP6F0nC0J9DsDk
         ZGfIiJg9tIOvhGlUnT/vblhTlS1l8DCLi/XzhBGuPVbEDvbhM3NoeWEQQniOeV2kQ6HX
         EnfiPtcoNp/rIuJtyqtY4RJhmHmMdElTe0i0INQquZR1n17KZPjUvI/HZLy6eCbdHsyd
         0nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eaHXmf2PauUwbh2A2MPaTE0oM/kMlZ6+C9nCeVhgAw=;
        b=SjCsS6lzdpSV/loEKChuxJSCTwCoqGBjYmFeaZOCVT+Hbtb8ac1KLoYjf21vfw5FDu
         fnv/eNonk9BMZqtZzf0nTaTGaNBa27Zn5smDt1xQcI1jrKZDhcvrR2OBBGMGpJs3zx9J
         HeHEn8gA48IdZnn6krgPYcM1iy7q7h6eHQkuV9tyzNTH7kLlFaf3XkuQzKkRbTrFiPfW
         +2ETY/cZriZ2ZFLCcCU6rK/nRbtGcGvq3xOKpERSyj8H2/na6hHCf/MEiL+Zw8nuYS70
         NpEuiFcOkFfv7oZT9kyo0X91xowb65s8+Rm/9ZzhmJQtNhAMOZUT/Wfl3bUrKGJ2qAal
         rX8Q==
X-Gm-Message-State: ACrzQf3cdvpzOua2r0XbWRap5RaXL9dnxMQWJs9YwkJG2PoTLsrkT8gR
        2//QAyOtNwhy1ND+Xz7Li65+BHtu3PV0DkhVTzeO/g==
X-Google-Smtp-Source: AMsMyM4dp0XXTZUH2UpiSDVwfSTLQVkRqIkPeHMzsLPQhJ35ipysopTbp06N1YUyt5vY4qn4Vt0xZdJG2edZHfmRc4Y=
X-Received: by 2002:a05:6808:1184:b0:350:f681:8c9a with SMTP id
 j4-20020a056808118400b00350f6818c9amr20243199oil.282.1667587139286; Fri, 04
 Nov 2022 11:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <Y2QR0EDvq7p9i1xw@nvidia.com> <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com> <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com> <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com> <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
 <Y2VaSZcX7uqRvRf3@nvidia.com>
In-Reply-To: <Y2VaSZcX7uqRvRf3@nvidia.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 4 Nov 2022 11:38:48 -0700
Message-ID: <CACT4Y+awm4SLe4jBOFNTNYT1KAi+zvDWfXik79=eASc4bPC98w@mail.gmail.com>
Subject: Re: xarray, fault injection and syzkaller
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zhengqi.arch@bytedance.com, Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Nov 2022 at 11:30, Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Fri, Nov 04, 2022 at 11:21:21AM -0700, Dmitry Vyukov wrote:
>
> > But I am not sure if we really don't want to issue the fault injection
> > stack in this case. It's not a WARNING, it's merely an information
> > message. It looks useful in all cases, even with GFP_NOWARN. Why
> > should it be suppressed?
>
> I think it is fine to suppress it for *this call* but the bug turns it
> off forever more

Is it just "fine", or "good"? I agree it's probably "fine", but
wouldn't it be better to not suppress it?

The message fault injection prints is not a warning, and the
allocation failed due to fault injection. That may trigger subsequent
bugs just as any other case of fault injection. Why don't we want to
see the info message in this particular case? NOWARN looks orthogonal
to this, it's about normal slab allocation failures.
