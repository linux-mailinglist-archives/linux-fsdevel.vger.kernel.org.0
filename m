Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179E418A2A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgCRSuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 14:50:52 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:38080 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:50:52 -0400
Received: by mail-il1-f180.google.com with SMTP id p1so9860055ils.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/S7otQDg1db0JdFySEmcj0bJn5SQ9oQCgo6CmcUwScw=;
        b=JCsGMaUIvNUn8sCChx4nhmL4hzcpXdoqkyTFvJejfOJa+l4CwTrQP8l6HHyinQ7mqc
         NbwHI3fysZL6zes+B6ZXnRYj4WaoDHKP92OhRrAs895N/roqR24d8LuTbjMOzne0to7s
         8gR33k1FE7hITldVfWmLqul4M+pxA2woK80Ev9Vb0OQevlCsLdmx7vy+Qs+v6GcyOsH3
         /SLbWZNS4y3MqDM0jRBSgKmF+yyvXb2AICXMQ7BgfjyiiH9Xz7TYOpcZxejo0yoLI4xZ
         gmP4rEvDHqJM7wy9kxGHgV46P3ZR0LBVGGjX9XjJETKqwW43iUHYJt6LOouvMRhLe+F4
         nkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/S7otQDg1db0JdFySEmcj0bJn5SQ9oQCgo6CmcUwScw=;
        b=brNLdw6LGVA++vkTUbwnBXkM4aIMKNx+3K0N/jU9Nm4d6YxfWePhNHDqGuZT39zgmg
         LbS3hZZiTxAPHxFrU2Ju4IIdyjOrqFK0Te1sil9XB23XUoruFauTfiIU0qJFUHdCyTvn
         N+I61l3EH8B3gSA36mtgt3E5ox+ftXrejFFCmYEazWJpeWCI5iXlk7EBUJRkTnPC6O3F
         0GDeFRU/0M2scZjfVcelPQHvoCMV/v4Xlc1zo65n7VfCrHtOPwG6+RNfBvVs6SfEEBp4
         g0iXZ7aHhdA/Vf+BVsb/ZEBZGnEtnJ3axO2x5cVydGw84mb1PKU8ZQusM74W/y4Bbewy
         aGtA==
X-Gm-Message-State: ANhLgQ0+gj4TUBNbTHjZ58fXNF+fZJZX5CK7ehPFajXm83HIJugSgsfg
        aOlcNuk3Fpn+uJJiHGUMqcAjdwRo8xFJ3X0qVSGAO+pg
X-Google-Smtp-Source: ADFU+vtxOCYWvekZ5X8tkmLqbR8eQ/cBjsfT7u5LMYAiqeCWSBgM8k6PBDloBMvRfKv3jfrrM67y9wOFM1RfVO8qV9M=
X-Received: by 2002:a92:bb9d:: with SMTP id x29mr5703352ilk.137.1584557450811;
 Wed, 18 Mar 2020 11:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxgW9Jcj_hG639nw=j0rFQ1fGxBHJJz=nHKTPBat=L+mXg@mail.gmail.com>
 <CAOQ4uxih7zhAj6qUp39B_a_On5gv80SKm-VsC4D8ayCrC6oSRw@mail.gmail.com>
 <20200227112755.GZ10728@quack2.suse.cz> <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz> <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz> <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
 <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com> <20200318175131.GK22684@quack2.suse.cz>
In-Reply-To: <20200318175131.GK22684@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Mar 2020 20:50:39 +0200
Message-ID: <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Pushed the work to fanotify_name branch.
> > Let me know if you want me to post v3.
>
> So I went through the patches - had only minor comments for most of them.
> Can you post the next revision by email and I'll pickup at least the
> obvious preparatory patches to my tree. Thanks!
>

Will do.
Most of your comments were minor, but the last comments on
FAN_REPORT_NAME patch send me to do some homework.

I wonder if you would like me to post only the FAN_DIR_MODIFY
patches, which seem ready for prime time and defer the
FAN_REPORT_NAME changes to the next merge window?
Or do you prefer to merge all the planned event name info API
changes at once?

Thanks,
Amir.
