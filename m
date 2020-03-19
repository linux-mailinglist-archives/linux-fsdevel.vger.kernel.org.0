Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E81B318B03D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 10:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSJaV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 05:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCSJaV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 05:30:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E636CAC77;
        Thu, 19 Mar 2020 09:30:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B198B1E11A0; Thu, 19 Mar 2020 10:30:19 +0100 (CET)
Date:   Thu, 19 Mar 2020 10:30:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 11/16] fanotify: prepare to encode both parent and
 child fid's
Message-ID: <20200319093019.GM22684@quack2.suse.cz>
References: <20200227112755.GZ10728@quack2.suse.cz>
 <CAOQ4uxgavT6e97dYEOLV9BUOXQzMw2ADjMoZHTT0euERoZFoJg@mail.gmail.com>
 <20200227133016.GD10728@quack2.suse.cz>
 <CAOQ4uxghKxf4Gfw9GX1QZ_ju3RhZcOLxtYnhAn9A3MJtt3PMCQ@mail.gmail.com>
 <CAOQ4uxiHA5fM9SjA+XXcGQOg2u4UPvs_-nm+sKXcNXoGKxVgTg@mail.gmail.com>
 <20200305154908.GK21048@quack2.suse.cz>
 <CAOQ4uxgJPkYOL5-jj=b+z5dG5DK8spzYUD7_OfMdBwh4gnTUYg@mail.gmail.com>
 <CAOQ4uxg4tRCALm+JaAQt9eWuU_23c55eaPivdRbb3yH=kcey8Q@mail.gmail.com>
 <20200318175131.GK22684@quack2.suse.cz>
 <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj7Q8wMWzhgvTt1YkZUuWn55U6aWPvtGv7PmknHBApONQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 18-03-20 20:50:39, Amir Goldstein wrote:
> > > Pushed the work to fanotify_name branch.
> > > Let me know if you want me to post v3.
> >
> > So I went through the patches - had only minor comments for most of them.
> > Can you post the next revision by email and I'll pickup at least the
> > obvious preparatory patches to my tree. Thanks!
> >
> 
> Will do.
> Most of your comments were minor, but the last comments on
> FAN_REPORT_NAME patch send me to do some homework.
> 
> I wonder if you would like me to post only the FAN_DIR_MODIFY
> patches, which seem ready for prime time and defer the
> FAN_REPORT_NAME changes to the next merge window?

Yes, that's certainly one option. AFAIU the patches, the FAN_DIR_MODIFY is
completely independent of the new feature of groups with FAN_REPORT_NAME,
isn't it?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
