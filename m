Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCA4B9557
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Feb 2022 02:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiBQBTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 20:19:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiBQBTf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:19:35 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEB42A0D41;
        Wed, 16 Feb 2022 17:19:22 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKVS3-002MiI-Le; Thu, 17 Feb 2022 01:19:19 +0000
Date:   Thu, 17 Feb 2022 01:19:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Steve French <smfrench@gmail.com>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hyeoncheol Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2] ksmbd: fix racy issue from using ->d_parent and
 ->d_name
Message-ID: <Yg2il8C+WUhm+erf@zeniv-ca.linux.org.uk>
References: <20220216230319.6436-1-linkinjeon@kernel.org>
 <CAH2r5msqTrGG2caTFCG4BL29obk86dfgocRJ3=F0YEaonE8JQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msqTrGG2caTFCG4BL29obk86dfgocRJ3=F0YEaonE8JQg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 16, 2022 at 07:10:05PM -0600, Steve French wrote:
> Do I need to update ksmbd-for-next?

I'll review tonight or tomorrow.  Sorry about delay...
