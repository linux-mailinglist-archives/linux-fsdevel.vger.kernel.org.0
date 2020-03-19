Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B9D18B0EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 11:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCSKH1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 06:07:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41529 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSKH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:07:26 -0400
Received: by mail-io1-f67.google.com with SMTP id y24so1593321ioa.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 03:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZa4B+j6t3nwea7Fi0x3cUYeHrjjwK4DR8ZIL5Ye6xU=;
        b=k4mQe+K0nCFU/B4T4lTbvV27HXNeBf385E1TP1Mkb5PXNw16pJ5tDLJVekucSuBKDE
         ECZx4o9Q0WGyKJR5r/ASIKjCVXLplJ4MPWnsjKwoq9LfdMK7wEn297ewY8erUrW0xXBB
         xtvtIYg/AHmevvvs1/1Db0f0tjok+bNr8r5b6ZnPTMPg4Yp1zsF2ZReRNFuZzBmZj/er
         9HHbns1yB6Yh9rZwOilnzSLEV3vr+sfdxJ8gDYnmOGP+vzl1XgRA5xMbVnTRPPc3VUiH
         Vb1MIdUWkJc5eKRIJ4laxu8V3P+CY/t6mSxtPCs7ej6mYwY3fTA4SQs7Ku7A9bqcM5hl
         1JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZa4B+j6t3nwea7Fi0x3cUYeHrjjwK4DR8ZIL5Ye6xU=;
        b=CUYgMMN5q2J3DZeJRDnTX+D1hZB5bywWIrU6eOc4JlFfxERtn4aTgCmETDFXQuQuv5
         K/ZvPXINg2IvdRg4NkpNxNIbv1RlTAcU4FKsoPg+UsrEsyeyQ2Aqc1hf++bAU7Fj45jn
         eJvSKcA7sEZvCG1nennDtbwLqQKZgP+cVE8owVSkqrEI2G96iL44MAZ2Nb8w7yOdGsPf
         nPn0oOKbSgtDJcyWKHskpEWBGGipgxKJYSGyxZEoBRwqzO8a4v0kpSCoNjmx5CESp/sf
         tmQHY2epYyOETnX5Q0//CPhclUcJ0CuP6KYlU7AUXxnewA9MbSWrU6iseFenlLvV0WuU
         tNdg==
X-Gm-Message-State: ANhLgQ3sdOfBtV9n0BpGeTh+LO6Fkry68Uyi0wPxylkViFfFiWPl4zdi
        1poyOpqd/PPfNbYyk3b+VbXqZDNBu0cshJ1OInI1JCia
X-Google-Smtp-Source: ADFU+vtBUfzCIpIrLXh//riE8UZS26N3cD8G8iMbPU5jXyO59gSDE1/MYfJx7KDXuqBGvWVV9b9Zp2hr1+QJFrPf/Ew=
X-Received: by 2002:a02:b897:: with SMTP id p23mr2426258jam.120.1584612445776;
 Thu, 19 Mar 2020 03:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz> <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
 <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
 <20200318175131.GK22684@quack2.suse.cz> <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
 <20200319093019.GM22684@quack2.suse.cz>
In-Reply-To: <20200319093019.GM22684@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 Mar 2020 12:07:14 +0200
Message-ID: <CAOQ4uxiFT8f0LTX39SNrP_RnYY=6P7cickSKGiertrWwLjPfeA@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:30 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 18-03-20 20:50:39, Amir Goldstein wrote:
> > > > Pushed the work to fanotify_name branch.
> > > > Let me know if you want me to post v3.
> > >
> > > So I went through the patches - had only minor comments for most of them.
> > > Can you post the next revision by email and I'll pickup at least the
> > > obvious preparatory patches to my tree. Thanks!
> > >
> >
> > Will do.
> > Most of your comments were minor, but the last comments on
> > FAN_REPORT_NAME patch send me to do some homework.
> >
> > I wonder if you would like me to post only the FAN_DIR_MODIFY
> > patches, which seem ready for prime time and defer the
> > FAN_REPORT_NAME changes to the next merge window?
>
> Yes, that's certainly one option. AFAIU the patches, the FAN_DIR_MODIFY is
> completely independent of the new feature of groups with FAN_REPORT_NAME,
> isn't it?
>

That is correct.
From UAPI perspective, I wanted to tell the final story and show that
it looks coherent, but even the man-page draft changes are in two
separate patches:
https://github.com/amir73il/man-pages/commits/fanotify_name

So there is no problem with merging them seperately.

Will post only FAN_DIR_MODIFY for v3.

Thanks,
Amir.
