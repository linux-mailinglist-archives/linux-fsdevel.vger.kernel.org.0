Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180DA29BB84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 17:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbgJ0QQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 12:16:35 -0400
Received: from verein.lst.de ([213.95.11.211]:40210 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1788549AbgJ0QCp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:02:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECB9B67373; Tue, 27 Oct 2020 17:02:42 +0100 (CET)
Date:   Tue, 27 Oct 2020 17:02:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] afs: Fix copy_file_range()
Message-ID: <20201027160242.GA26923@lst.de>
References: <160380659566.3467511.15495463187114465303.stgit@warthog.procyon.org.uk> <160380660321.3467511.6644741119983042797.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160380660321.3467511.6644741119983042797.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
