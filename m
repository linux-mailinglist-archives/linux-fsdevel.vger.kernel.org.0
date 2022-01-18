Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC69E49238C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 11:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbiARKLX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 05:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiARKLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 05:11:22 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB08C061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 02:11:22 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id z22so53677582ybi.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jan 2022 02:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pnsd74l69supgNeOC7PzLSTBsqi2Vo6y5p3oVEw+GPs=;
        b=i32yUy0T4Q7EaqlNRe8eS/po0yllf4ajmDpXZEg1gELx1cDTngFJr2x1GUpb6hNnyQ
         ol1NKJLd1Q22RQDVKjRy4UEE4aDzedUmfIkgZZ2Sf+mVELjLVNtdc/N+cWSDKBHscK+r
         1tbwI7s0nFgoLvcE5aYrtRNSnz+rfj3vmjbt/WoF6I21wlIZ6MSbqvxG2IdMv9vjm39M
         lbfscsQO3pJBxEX8NDYQQWerw4FLiSdWnIBIX/Mi+7159m1sW68kYsn8eqg5xtKFuQgQ
         mNM95Xqo8C1cljzcTMMUhKX3D1ATWauqdEW+Q9fYVUdwUXB+4m7t8eapDtvrktu1xcbi
         cB4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pnsd74l69supgNeOC7PzLSTBsqi2Vo6y5p3oVEw+GPs=;
        b=QCSety8wpwYAGXSXF3/5UCYP+zogFzVaVuCE5i4tPYo1MoOgSKH81g7CbPYvrfcde5
         9fT4/9ElHI8oALWds4Px9EeLRnmNV90vVUqC37wIdIPSESD6TpC7tZ/q9TTppwOQ0qvc
         NOHNKt3cvXOLpuM1tZVZnOwdhRiC0Jo6LAZ0E+o7Q6I0cRTAf11iRol6g4CtPHUON1hv
         InwTewskH+YP+UYbZgrxJk3fYS0V0vcUWr2jfGjsWGSJJaEldClLvn8xi/fteA8m2xcC
         9TZJ5HNa/sQm6xDcubZF9oyK9orA1N7Z8RApSVG41WKQacma4tHTb0fpioHU2xWmpuD9
         l9Ig==
X-Gm-Message-State: AOAM532qJzsFejME0sIpOsyei3COAl3fQJreOc1Z5fnWE32k7/UAYYTu
        m55cBMrKyNFraoQmC3kFnWuWGD6UeZerdPc6z+eB+FKaLys=
X-Google-Smtp-Source: ABdhPJxXh6mHZatfblbJrEmrdCvzmwP0C9Fc9PNnKmJvER//9bhcnJe32Hx4eWpjZJGy/UR0w/+nY7ztiuGkvVmCy7I=
X-Received: by 2002:a25:7c87:: with SMTP id x129mr25261825ybc.300.1642500681480;
 Tue, 18 Jan 2022 02:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20220118095449.2937-1-jack@suse.cz>
In-Reply-To: <20220118095449.2937-1-jack@suse.cz>
From:   butt3rflyh4ck <butterflyhuangxx@gmail.com>
Date:   Tue, 18 Jan 2022 18:11:12 +0800
Message-ID: <CAFcO6XNLXyoKzTRhOYpQoaHJaPP8+bWuKzMz7QymUWb8oMt-MA@mail.gmail.com>
Subject: Re: [PATCH 0/2] udf: Inline format expansion fixes
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for the update.

Regards,
  butt3rflyh4ck.

On Tue, Jan 18, 2022 at 5:57 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> these two patches fix problems identified by a syzkaller in expansion of
> inodes with inline data. I plan to queue them in my tree.
>
>                                                                 Honza



-- 
Active Defense Lab of Venustech
