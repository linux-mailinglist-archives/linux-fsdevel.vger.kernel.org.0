Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019D47A9F37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjIUUTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjIUUTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:19:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD12D24872
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226b8de467so514552f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695316291; x=1695921091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=scj82o0/MXXh/axI8HyM/frmW+Em4Mre8DET66j3F2g=;
        b=YhAolCCSKvXqXyZEiZUC/naTvBqiKIKZ0q8uOycWxng3K2CLb31a7j7fw03jlxC7Ho
         JGaZbJZysTl+A1yE2PuZ8ku3iPSpiD0yCvCMTqVspS3O05J6A+9AzLFIJ92gX1JPGV2R
         3hVEaIXbBLH52WPIKO1MaZJbbjJ8IxUx7anEJqj5ZFk9K+6QxQ2FqO1Pp4iBzBKWP0TC
         gdVKqkweicS9SaGX5As5dQG2XURvqih/RalUz7tjyU7mqXpg/EbKWAwTbyE8ba7bdSsu
         tyhyeJjtItCBBvZH9iC++0htQCAhTEdlFdbCnibMnD6+d8nBq7Xw/cr7DqC1ArIlxE/M
         Epsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316291; x=1695921091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scj82o0/MXXh/axI8HyM/frmW+Em4Mre8DET66j3F2g=;
        b=sFE4Vba3MWfWZ7neMI2HI6VYWe5cukYaG0OyIjI4a1TUrw6bnONXuMhSmD7wSih4zy
         wn+wAxGEsfnFBjDhgKo0UDidOk9/GkonEsa9r39PI/6LcjQ4hmpRZyaXG1Kkg1MCxVRF
         PXGeeSXrqOkjihnvWkl95TXjaF2IZzr3f1fuQ8HezpmimbbtyM3Ed/WbN62+RNRvkAlO
         aqvv6FXtdWLBwBoxFbsX/V/0nUnr+Vaa6upOB1zeW7o7/r9ShBEKUa+K8r8k6JcGTFNc
         ch94sViMGojVbxgl3TaXgoeYDwTYzeReEQIGHyrdiXWT2Awz/F2vo5w+brYFp8mDJJTF
         Decg==
X-Gm-Message-State: AOJu0YwoexxtvrRrYV2DyLpwJq5f6K/Sq5FJqRGPyeRv9oeRJRUDHWvM
        s7HrGttHjMDDsZp7opfP0DaUguCwAwysrRLew/fE/Dc3lswcB9As
X-Google-Smtp-Source: AGHT+IHRNKYt6SzvFqYeDcI8VMmjvjvhgLxRwyFKpkFgygUFVne/MMEEHrOe4Uh7BOLfYYQMzRYPQKDl+KpeNv2K5Y4=
X-Received: by 2002:a2e:9b15:0:b0:2bc:dd96:147c with SMTP id
 u21-20020a2e9b15000000b002bcdd96147cmr4182814lji.34.1695283535225; Thu, 21
 Sep 2023 01:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner> <CAKPOu+_Ebj6-YXPd4HWqG7TokZDvw26uM4xuJGL7k0gg+tHeyw@mail.gmail.com>
In-Reply-To: <CAKPOu+_Ebj6-YXPd4HWqG7TokZDvw26uM4xuJGL7k0gg+tHeyw@mail.gmail.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Thu, 21 Sep 2023 10:05:24 +0200
Message-ID: <CAKPOu+9RC6XCKh0a0HNEFmjPCn8n=BvGwRHk13hJKWD2N_+OcQ@mail.gmail.com>
Subject: Re: When to lock pipe->rd_wait.lock?
To:     Christian Brauner <brauner@kernel.org>, dhowells@redhat.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:28=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
> I had another look at this, and something's fishy with the code or
> with your explanation (or I still don't get it). If there is a
> watch_queue, pipe_write() fails early with EXDEV - writing to such a
> pipe is simply forbidden, the code is not reachable in the presence of
> a watch_queue, therefore locking just because there might be a
> wait_queue does not appear to make sense?

Meanwhile I have figured that the spinlock in pipe_write() is
obsolete. It was added by David as preparation for the notification
feature, but the notification was finally merged, it had the EXDEV,
and I believe it was not initially planned to implement it that way?
So I believe the spinlock is really not necessary (anymore) and I have
posted a patch that removes it. (David, you would have received my
submission, unfortunately I misspelled your email address....)

Max
