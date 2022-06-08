Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF700543010
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiFHMOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 08:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiFHMO2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:14:28 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2527AE472
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 05:14:25 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id r12so16797618vsg.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UphCuTEHGjwSL9MTgnC/UFi4c6fLqWmcDLiOGFRdqjc=;
        b=a9pBJI68sosVxORhsfsFVR86Ytgt/JCJ+7b8yzMYUUoILN9OqKi7/9HRM1FkhDXioR
         8my35aTDUkrdF9PtTkn9SNecP+q/y8ILDX8KP+z0ytRI1ANSmYcpuzafMvxkAt6y/lGg
         mKofHIqNG+Zkya7YhpRtHK7GN3cdYiZxwq/lW0utHMRn9iKdWlU44OXwFJIPcazFPIWR
         VB6nBfhQ6UvSe2+WvUM7APhygY8s4jpwoGIb2iRc0nX9NeRN+j4U5hpZxrEBQelu9Uvv
         pFl68ADRUwo3jXUonTakB3L+kIoZLSrVW7mTTTxgsDqovvvGmZ4Ve/786eR/Dzu3YqNB
         NPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UphCuTEHGjwSL9MTgnC/UFi4c6fLqWmcDLiOGFRdqjc=;
        b=tT6V2FDcXDCdVicrRQeBleGRQpOjTPOZFsANVyNysEvKbq15cNOPcbN5nrHHxkb+ll
         lg+OHtdA5eGEz+Jq3Mmt+Bk5iCpRh4kMy2IKDDsl6RJKlQK6LZmEQ2EqnvvtpwiAsA8q
         H6NoMMj+k+ns9RzQdny/bLmN5U5AVb1212r9PgvqQ8oFdFs1exA5jtkuOACuPpak3tSZ
         zMQ/ffvvjnJHJzvuojELA6upGazzhX/bkuffn83SJrgXQOQGKaoS+CoG3/CdNMF7XApH
         R/CqzaVrpi+aPXxk+vQ+/CcjjTn8EYLl53c+7O5XBarkvxytPU61yPw/3sD5o7a3vbR/
         9feQ==
X-Gm-Message-State: AOAM530okAYKVa76Th0Zq+HxqcGT7+isW1N5l0GZ3nIdBTjUByKYFbvP
        /5Jz3zu2V4apn5kBNiIImHJJm7yph6L0gyLvYOhe0nsb4Wy8jw==
X-Google-Smtp-Source: ABdhPJxnuSbA9SJFpK5WT2h4VBcwqUG/byIKzx0EGK4QMtcnLqk49q455fSKB46SG1bX0mvOeKxyFq1OFxb8llwZexk=
X-Received: by 2002:a67:486:0:b0:349:e59c:51f4 with SMTP id
 128-20020a670486000000b00349e59c51f4mr16832084vse.3.1654690463579; Wed, 08
 Jun 2022 05:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
 <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
 <CAJ-MHhBkKycGJnMVwt+KuFnzz=8sDzyuHWTxvHVJnJ55mKLiPQ@mail.gmail.com> <20220608115738.gcnviw7ldunw6vb5@quack3.lan>
In-Reply-To: <20220608115738.gcnviw7ldunw6vb5@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 15:14:12 +0300
Message-ID: <CAOQ4uxif8aoYBqLZp30Sf6Ad5MKWh+sYBZJ7kT3yRtabnNYJ9g@mail.gmail.com>
Subject: Re: Failed on reading from FANOTIFY file descriptor
To:     Jan Kara <jack@suse.cz>
Cc:     Gal Rosen <gal.rosen@cybereason.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 2:57 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello,
>
> On Wed 08-06-22 14:33:47, Gal Rosen wrote:
> > One more question, if I do get into a situation in which I reach the limit
> > of the number of open files per my process, can I continue ? Can I continue
> > in my while loop and after a couple of microseconds for example can try to
> > re-read ?
> > If I get the error of EMFILE, it could be that some of the events
> > successfully read and are already in my user buffer, but I still get return
> > value of -1 on the read, does all the successful events are still in the
> > kernel queue and will be still there for the next read ?
>
> So if you get the EMFILE error, it means that we were not able to open file
> descriptor for the first event you are trying to read. If the same error
> happens for the second or later event copied into user provided buffer, we
> return length corresponding to the succesfully formatted events. Sadly, the
> event for which we failed to open file will be silently dropped in that case
> :-|. Amir, I guess we should at least report the event without the fd in
> that case. What do you think?

Yes, that is unfortunate.
We could return an event without fd.
We could return the error in event->fd but I don't like it.
We could store the error in the group and return success for
whatever events have been read so far, then on the next read
we just return the error immediately and clear the group error state.

That will keep existing UAPI semantics intact.

BTW, in the category of possible errors from reading event there are
also ENXIO ENODEV when a process tries to open a device file
with nothing behind it, which is very easy to reproduce.

Thanks,
Amir.
