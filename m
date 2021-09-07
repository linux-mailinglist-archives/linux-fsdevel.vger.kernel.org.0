Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2640307A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbhIGVzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 17:55:54 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:49766 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbhIGVzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:55:53 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNj3G-0028IM-2x; Tue, 07 Sep 2021 21:54:46 +0000
Date:   Tue, 7 Sep 2021 21:54:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] namei: fix use-after-free and adjust calling
 conventions
Message-ID: <YTffpkfmGBlOsOCa@zeniv-ca.linux.org.uk>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
 <YTfVE7IbbTV71Own@zeniv-ca.linux.org.uk>
 <87tuiwrrhn.fsf@stepbren-lnx.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuiwrrhn.fsf@stepbren-lnx.us.oracle.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 07, 2021 at 02:43:48PM -0700, Stephen Brennan wrote:

> >From the links in the blame it seems this was suggested by Linus
> here[1].  The core frustration having been with the state of
> __filename_create() and friends freeing filenames at different times
> depending on whether an error occurred.

Sure, but that's an argument for IS_ERR(), not the IS_ERR_OR_NULL() shite...
