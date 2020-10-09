Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838B1288DA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 18:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbgJIQEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389135AbgJIQEE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:04:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D9CC0613D2;
        Fri,  9 Oct 2020 09:04:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t25so13760528ejd.13;
        Fri, 09 Oct 2020 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvtPxYNhwku9SDk2UQAbKTUxPDeyE2XXYjEh7mB3wQk=;
        b=GgSDQbLC8Unon0lKHbHT3tnzClpR7OQjOnp56W7cUAg4nF0ZYLKlNRIsNa3s4+J3Jk
         ZVQAq/+lwD/yPaqWO4ozMimWheJLB0OmsDAXQy0SXbrblvC5RM0wdZlY+84z/h7RuNPM
         GFZe1ORPwC1ZKa7Gk/DHpUwnstMYvCzi9A5W792Dxu0+b1H7Wtg6De425TKH5w0YO/9B
         obqJeMA13qFXuHRNAtlIf3Z9/0UE+gDt4bO2EGkfS5jRpdv5cQ68rOJAduGRQkNWUMZa
         RCRclK1Ok66cCiaQX/lEMT3fyHv5h2ZgxIGJzCEXviHJqVRI889o/dCuuNcj4tmLeyuJ
         ZEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvtPxYNhwku9SDk2UQAbKTUxPDeyE2XXYjEh7mB3wQk=;
        b=AHyC9+T2yG+ywkDYmGd2A3pqUALOTNNqPD2R1h0xl6crO0uZsL6hj0DvJtMU3Simpu
         tAlvdjN9rwGmOT3TBj3oekgdzfmfWYiTbtncZ+B390La0C0naZkcuaYFwqzSWNdnsOco
         BIjCUF2M2PHcYHQKR+xPzP9Gw2jyWX12XlIeHVVVyM79wjP6NQojVKUtGq9bAo7WfKDl
         DiQzwzmjTtyW+KjNjwH1IQ+YhUcjdKX5IC5W8MLDUuPuHADrU4qLohErCxbUACr48gVe
         UI+cAdMMMpM3PPB7djWWAV+R0qEokvXpzDBZYm65coSNQ0omyIAvoT0WiPgNzA9hHFFV
         ssyg==
X-Gm-Message-State: AOAM533XWfGwHbun7gBp1lyKgmwpDYUxBJ0cNn+pjlI2C9Z47XgSlip4
        2GcU4xnzxyqyT+N8vCqX0T64jkOb0Il2rK5MFQGrkDFErzs=
X-Google-Smtp-Source: ABdhPJw6XVrIDfcloA0XMmhZsmq9+6bI9Y1j5dbIVTQl5Pm6kU02en5asLapn8/oN4yeXecMzn/cykRKL4IA+Rg3wY0=
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr14823782ejb.187.1602259442615;
 Fri, 09 Oct 2020 09:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWkE5CVtGGo88zo9b28JB1rN7=Gpc4hXywUaqjdCcSyOw@mail.gmail.com>
 <CA+icZUVd6nf-LmoHB18vsZZjprDGW6nVFNKW3b9_cwxWvbTejw@mail.gmail.com>
 <CA+icZUU+UwKY8jQg9MfbojimepWahFSRU6DUt=468AfAf7uCSA@mail.gmail.com> <20201009154509.GK235506@mit.edu>
In-Reply-To: <20201009154509.GK235506@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 9 Oct 2020 09:03:46 -0700
Message-ID: <CAD+ocbxpop9fFdgqzyObuT5oA=2OpmPj7SeS+ioH6QBvN_Ao6g@mail.gmail.com>
Subject: Re: ext4: dev: Broken with CONFIG_JBD2=and CONFIG_EXT4_FS=m
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks Sedat for pointing that out and also sending out the fixes.
Ted, should I send out another version of fast commits out with
Sedat's fixes?

Thanks,
Harshad


On Fri, Oct 9, 2020 at 8:45 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Oct 09, 2020 at 04:31:51PM +0200, Sedat Dilek wrote:
> > > This fixes it...
>
> Sedat,
>
> Thanks for the report and the proposed fixes!
>
>                                         - Ted
