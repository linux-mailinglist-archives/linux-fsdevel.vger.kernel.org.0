Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531FB1D1F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 21:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390352AbgEMTdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 15:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390158AbgEMTdM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 15:33:12 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA64C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 12:33:12 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYx7u-007iQi-4r; Wed, 13 May 2020 19:33:10 +0000
Date:   Wed, 13 May 2020 20:33:10 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 03/12] proc/mounts: add cursor
Message-ID: <20200513193310.GX23230@ZenIV.linux.org.uk>
References: <20200505095915.11275-1-mszeredi@redhat.com>
 <20200505095915.11275-4-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505095915.11275-4-mszeredi@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 11:59:06AM +0200, Miklos Szeredi wrote:

> +	for (p = p->next; p != &ns->list; p = p->next) {

Nit:
/**
 * list_for_each_continue - continue iteration over a list
 * @pos:        the &struct list_head to use as a loop cursor.
 * @head:       the head for your list.
 *
 * Continue to iterate over a list, continuing after the current position.
 */
#define list_for_each_continue(pos, head) \
        for (pos = pos->next; pos != (head); pos = pos->next)
