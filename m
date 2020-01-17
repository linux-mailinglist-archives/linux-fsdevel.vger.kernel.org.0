Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1BC140987
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 13:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgAQMNZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 07:13:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38447 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgAQMNY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:13:24 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so21959395oii.5;
        Fri, 17 Jan 2020 04:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j9LdKm6yNd5aXn+rN0edQ8Jaz0F5s+sFTFnF9WgkgBY=;
        b=hwT52K1dJOOsr+O6qALLUpZhk9Jfylg2E/jmuJiqovVYnNtANFj8pHkWHPd3kCTSwT
         XTVloVKx+xw0fFVM1eIOmElCJ0ZEUKai+JyYq0m2cZ7G83TtZABDckiQgwL35PkuaO16
         m5xpG+cjJAr99XFuLFK5gzilba4QRN8ZYKOqbsoGYa/BfDsGTCAWJ+D+bKj0Y6orJQGY
         ebQisqQHEilstcz2sOsCqnWbyu0ptJOMtss3i7917tMQq6wy7R0iL1wjsLfQFCpCb6gL
         jgod+mlBxJfVhbp3APRYAoI7AM/hK2KTU/12HDo5qvrHzTHO79z012kCG5kvyWMS5WN2
         4tOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j9LdKm6yNd5aXn+rN0edQ8Jaz0F5s+sFTFnF9WgkgBY=;
        b=UH5QBDQrxl0Rr+J/QFW2M9cXUgDe7QDeQ/fGUjmRkDPl67N2VkaEtMd6j7gEEcK+3V
         vDwSY9brRvAo9mPfAeZ9GSujlgTurHNBkP38rv6gvRm0ljgseIK3gVUlIS0m5lpi4/pP
         H9fqvc82jX9vgDlVTPSwcCKOb0b5kihspMp+MqEV+oC29od2/ejp3gTlgAZd/Su+BfLd
         pe/DHABhguStekRfbOOQNfxEE5GZQmipUNUghXT1u/rOFuzPBFPUfC00iBoHzOxRr3Wn
         FKd3ucYp1iiy6Ac2rXxqGzY9QPMbB9Mc6NMI9VYR28T/wOlA6IJWSKxIlLJGZclq9/cI
         3erg==
X-Gm-Message-State: APjAAAV2IOlDOXsWtdZwcUoMQQK1r4Cj5O+LxqE56ixx42aJ1Z6iZfgn
        452yK3SvFjOGcaqY1w6qrWRV66tT8o1Pn4Ds1Nc=
X-Google-Smtp-Source: APXvYqyK2sogu8+jyU3vGsF46DTDsA765vsyTHqA+AkGu0AcxB7pNmzp2BD3vbnNDBFAMn6+P87/6TH46HulpscBxmw=
X-Received: by 2002:aca:1b08:: with SMTP id b8mr3245485oib.62.1579263203997;
 Fri, 17 Jan 2020 04:13:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:87:0:0:0:0:0 with HTTP; Fri, 17 Jan 2020 04:13:23 -0800 (PST)
In-Reply-To: <CAK8P3a28NRp+SGr44=DTYqL0+ZqtamHwn+WYNTxVRJOJ3HtLSg@mail.gmail.com>
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali> <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali> <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
 <20200115153943.qw35ya37ws6ftlnt@pali> <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
 <002801d5cce2$228d79f0$67a86dd0$@samsung.com> <CAK8P3a28NRp+SGr44=DTYqL0+ZqtamHwn+WYNTxVRJOJ3HtLSg@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@gmail.com>
Date:   Fri, 17 Jan 2020 20:13:23 +0800
Message-ID: <CAKYAXd-eYLvduvnJhkF6my_XVpZSudnss0Qp35+-CUx_F_TUCA@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-01-17 18:13 GMT+08:00, Arnd Bergmann <arnd@arndb.de>:
> On Fri, Jan 17, 2020 at 3:59 AM Namjae Jeon <namjae.jeon@samsung.com>
> wrote:
>>
>>
>> > This is what I think the timezone mount option should be used
>> > for: if we don't know what the timezone was for the on-disk timestamp,
>> > use
>> > the one provided by the user. However, if none was specified, it should
>> > be
>> > either sys_tz or UTC (i.e. no conversion). I would prefer the use of
>> > UTC
>> > here given the problems with sys_tz, but sys_tz would be more
>> > consistent
>> > with how fs/fat works.
>> Hi Arnd,
>>
>> Could you please review this change ?
>
> Looks all good to me now.
Thanks for your review!
