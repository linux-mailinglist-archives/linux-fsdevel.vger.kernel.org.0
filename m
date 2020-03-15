Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87B0185D8A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 15:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgCOOXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 10:23:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49362 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgCOOXb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:23:31 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDUAh-00ByN6-Kp; Sun, 15 Mar 2020 14:23:19 +0000
Date:   Sun, 15 Mar 2020 14:23:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH v4 22/69] merging pick_link() with get_link(), part 4
Message-ID: <20200315142319.GT23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200315094148.12872-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315094148.12872-1-hdanton@sina.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 15, 2020 at 05:41:48PM +0800, Hillf Danton wrote:
> > +	link = walk_component(nd, 0);
> > +	if (link) {
> 
> Need to check that link is not err.

What for?  It will do the right thing anyway.
