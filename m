Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BBB185D9A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgCOOhJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 10:37:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49526 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCOOhJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 10:37:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDUO1-00ByfE-Tw; Sun, 15 Mar 2020 14:37:05 +0000
Date:   Sun, 15 Mar 2020 14:37:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH v4 26/69] sanitize handling of nd->last_type, kill
 LAST_BIND
Message-ID: <20200315143705.GW23230@ZenIV.linux.org.uk>
References: <20200313235303.GP23230@ZenIV.linux.org.uk>
 <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200315102905.12468-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315102905.12468-1-hdanton@sina.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 15, 2020 at 06:29:05PM +0800, Hillf Danton wrote:

> > And make link_path_walk() _always_ assign ->last_type - in the only
> > case when the value at the entry might survive to the return that value
> > is always LAST_ROOT, inherited from path_init().  Move that assignment
> > from path_init() into the beginning of link_path_walk(), to consolidate
> > the things.
> > 
> If you agree that the move is not a huge change, drop it for the sake of
> init in order to close the time window of a random last_type.

What time window of a random last_type and what does "drop for the sake of
init" mean?  Confused...
