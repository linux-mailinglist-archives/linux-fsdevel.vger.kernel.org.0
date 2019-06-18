Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E42049697
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2019 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfFRBMT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jun 2019 21:12:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36480 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFRBMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jun 2019 21:12:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hd2fY-00048L-I1; Tue, 18 Jun 2019 01:12:16 +0000
Date:   Tue, 18 Jun 2019 02:12:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Aurelien Thierry <aurelien.thierry@quoscient.io>
Cc:     linux-fsdevel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] fs: relatime update - Match comment with behavior
Message-ID: <20190618011216.GY17978@ZenIV.linux.org.uk>
References: <5553a3e1-bc49-4553-0648-91350be3ae9c@quoscient.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5553a3e1-bc49-4553-0648-91350be3ae9c@quoscient.io>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:45:40AM +0200, Aurelien Thierry wrote:
> 2 comments right before code wrongly state that if (c|m)time is younger
> than atime, then atime is updated (behavior is the other way around).
> 
> Fix aligns comments with actual behavior, function description and
> documentation (man mount).

Huh?  "mtime is younger than atime" means that mtime refers to the moment
later than that refered to by atime, i.e that atime refers to the moment
earlier than that refered to by mtime.  What is the problem you are trying
to fix?

Both the original and changed comments mean exact same thing.  And yes,
the changed comment does match the actual behaviour.  Just as the original
one does...
