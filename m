Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAA1B151B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 20:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgDTSro (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSrn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:47:43 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489FC061A0C;
        Mon, 20 Apr 2020 11:47:43 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id q8so8818340eja.2;
        Mon, 20 Apr 2020 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EeRaPROZPm4KsnawN7tT4cIjnbjK200DqVLhPIsrTZo=;
        b=T5wPDgyb3tZwWRTJqt92CfjTgFbIaVgRt/ZJFEytYc9yw2gfmU2vwl8vV5Q4PHjTxg
         hNsxrGmiCwotRimgansHTCVKK1og1Lut7h0rLvIgL7iVyevW3aHWuwKzTqbbjeho/nMf
         asX+Q1J1VK7kQiJ5u8dtc3yJQv/VdvbvAhFsp1+zoGMK6SVfzK1CDjUvFc3NVs+eSNNg
         GdRpD6GJn2A3urvQlm8aqg9Fd0t6EnFk0CWhCbfgkkuYecl23RLQmG1OJ61wW0vyIIev
         M9QQelZ32YiPPpFJxBF/K3OMq0j/t5hgJaXJLonJhXSAwJRYj08ZNsdcB6Z4VBFWv1zO
         +35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EeRaPROZPm4KsnawN7tT4cIjnbjK200DqVLhPIsrTZo=;
        b=kVDlDJK8pUdH6dXHBYt7UT932PVoXdxI16texUyCMI75z2gZYfIz+ZqRwLh3hcjq+L
         9TiuARcZDUGFi+phCAa8ebgWbZRmauTz2cyYshvHr4TWGbLyyaz5Shb6GRU1OnQAdE6B
         kXiPc3VpxSMRBD7DiUZ9j8/kKIubOmi3laVh2v6pwO2feCn1t4Fd39MOCxmNMA4wjebb
         jEhjmqVPTcreTes+ub/jCuCa6oFYo6tcPBK2ibVHz/NdYgeFyTuS3JJ7IcQStN/W5MYn
         bC5Bn4oo3XCPCJtQjbhGMukqs9kYHIKDMtRVDR3LmteyzmQ7b0mk1vscNTAop8WD02TM
         wwZQ==
X-Gm-Message-State: AGi0PuaPJfiA39K2KzQW6ts5pehrQg1Wk2eqCqIePmfH6/MMCqydQuI4
        P5uAGPKjMEMg6NYTLMP88xDXaLbEIXjXaUjHLtM=
X-Google-Smtp-Source: APiQypK9pqAeAvoGgBZ2HvbsZ4NQ789EFf0dziTLGUlWEeZGOh1g1m0Q5I9VFm6qQ+GrQ0dJwLz+yaH0C5e9rm+YZo0=
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr17862968ejt.150.1587408462064;
 Mon, 20 Apr 2020 11:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200217131455.31107-1-amir73il@gmail.com> <20200217131455.31107-14-amir73il@gmail.com>
 <CAKgNAkiVcjQfATKWwGNPDFucMEN4jJnQ5q6JHRzDihK1ZDnH8A@mail.gmail.com> <CAOQ4uxhx24iHDQHv02ei05eopVLQ-ytp9oepTy0q3xUDGr0dEw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhx24iHDQHv02ei05eopVLQ-ytp9oepTy0q3xUDGr0dEw@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 20 Apr 2020 20:47:30 +0200
Message-ID: <CAKgNAki_evV4tqpS1BLDdAGP4-5e0Htyjbsj88qjZ2MWMD7doA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] fanotify: report name info for FAN_DIR_MODIFY event
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 20 Apr 2020 at 20:45, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Apr 16, 2020 at 3:16 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Hello Amir,
> >
> > On Mon, 17 Feb 2020 at 15:10, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > > to how fid's are reported.  With name info reporting implemented, setting
> > > FAN_DIR_MODIFY in mark mask is now allowed.
> >
> > I see this was merged for 5.7. Would you be able to send a man-pages
> > patch that documents this new feature please.
> >
>
> Sorry, I missed your email.
> Just posted the patches.
> I never know when in development cycle you expect to get the man page patches...

Ideally,m the manual page patches are posted in parallel with the
kernel patches, with a note saying that the featur eis not yet merged.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
