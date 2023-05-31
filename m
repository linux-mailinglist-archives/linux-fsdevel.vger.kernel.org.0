Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8F718153
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbjEaNWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 09:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjEaNWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 09:22:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6DAB2;
        Wed, 31 May 2023 06:22:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4814868B05; Wed, 31 May 2023 15:22:00 +0200 (CEST)
Date:   Wed, 31 May 2023 15:22:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        viro@zeniv.linux.org.uk, dhowells@redhat.com, code@tyhicks.com,
        hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org,
        sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        chuck.lever@oracle.com, jlayton@kernel.org, miklos@szeredi.hu,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        dchinner@redhat.com, john.johansen@canonical.com,
        mcgrof@kernel.org, mortonm@chromium.org, fred@cloudflare.com,
        mpe@ellerman.id.au, nathanl@linux.ibm.com, gnoack3000@gmail.com,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next 0/2] lsm: Change inode_setattr() to take struct
Message-ID: <20230531132200.GB30016@lst.de>
References: <20230505081200.254449-1-xiujianfeng@huawei.com> <20230515-nutzen-umgekehrt-eee629a0101e@brauner> <75b4746d-d41e-7c9f-4bb0-42a46bda7f17@digikod.net> <20230530-mietfrei-zynisch-8b63a8566f66@brauner> <20230530142826.GA9376@lst.de> <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <301a58de-e03f-02fd-57c5-1267876eb2df@schaufler-ca.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 07:55:17AM -0700, Casey Schaufler wrote:
> Which LSM(s) do you think ought to be deprecated?

I have no idea.  But what I want is less weirdo things messing with
VFS semantics.

>
> I only see one that I
> might consider a candidate. As for weird behavior, that's what LSMs are
> for, and the really weird ones proposed (e.g. pathname character set limitations)
> (and excepting for BPF, of course) haven't gotten far.

They haven't gotten far for a reason usually.  Trying to sneak things in
through the back door is exactly what is the problem with LSMs.

> 
---end quoted text---
