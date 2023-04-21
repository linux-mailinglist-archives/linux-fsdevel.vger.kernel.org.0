Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2266EA1B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 04:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjDUCfG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Apr 2023 22:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjDUCfE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Apr 2023 22:35:04 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E822706;
        Thu, 20 Apr 2023 19:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vtqj3FSGR1RXgEZbgrRFgmdlK73HPN3DlXRsrPd9hQU=; b=drroy1s75UaQ92RRDYQONuD4IB
        VzxuGNxKKTcrSh4B1q3JUeaL5mN/B+y6iBX2SUoWYs8Q5JCydEFNTCdZdHcLPMG5dqxTRcb9gutvn
        ENgdJXKaoAjhrHLgjJOOaMcWovlgqD35qse2JN3sMg4wVN/QoFC/Z8q3W74+p5lCilaRIhX028nOJ
        YLm0ITlnG3sz5+rh1nh5UuAFZrHyXnU5JtW+WZBk2S3rQ0DjchXsqskdzKbucInLfmT8waj9vwJ58
        0CmIzh5b0XJJASNP9Kll5J8c/f2jUpbUZk5wZ2slDJdAgFuN/4lJuh/mvcvhSMcCGs8MFxGetbdbI
        YZlC3sMQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ppgc0-00B3Hk-0P;
        Fri, 21 Apr 2023 02:35:00 +0000
Date:   Fri, 21 Apr 2023 03:35:00 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        brauner@kernel.org
Subject: Re: [PATCH v8 0/3] ksmbd patches included vfs changes
Message-ID: <20230421023500.GY3390869@ZenIV>
References: <20230315223435.5139-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315223435.5139-1-linkinjeon@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 16, 2023 at 07:34:32AM +0900, Namjae Jeon wrote:

OK...  Let's do it that way: I put the first two commits into
never-rebased branch (work.lock_rename_child), then you pull
it into your tree (and slap the third commit on top of that)
while I merge it into #for-next.
