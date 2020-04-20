Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB21B10BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgDTPxU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 11:53:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:53688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgDTPxU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:53:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 628A7B021;
        Mon, 20 Apr 2020 15:53:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2DF0D1E0E4E; Mon, 20 Apr 2020 17:53:14 +0200 (CEST)
Date:   Mon, 20 Apr 2020 17:53:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 13/16] fanotify: report name info for FAN_DIR_MODIFY
 event
Message-ID: <20200420155314.GG17130@quack2.suse.cz>
References: <20200217131455.31107-1-amir73il@gmail.com>
 <20200217131455.31107-14-amir73il@gmail.com>
 <CAKgNAkiVcjQfATKWwGNPDFucMEN4jJnQ5q6JHRzDihK1ZDnH8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkiVcjQfATKWwGNPDFucMEN4jJnQ5q6JHRzDihK1ZDnH8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 16-04-20 14:16:40, Michael Kerrisk (man-pages) wrote:
> Hello Amir,
> 
> On Mon, 17 Feb 2020 at 15:10, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Report event FAN_DIR_MODIFY with name in a variable length record similar
> > to how fid's are reported.  With name info reporting implemented, setting
> > FAN_DIR_MODIFY in mark mask is now allowed.
> 
> I see this was merged for 5.7. Would you be able to send a man-pages
> patch that documents this new feature please.

I know that Amir has the manpage ready. I'm not sure when he plans to
submit it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
