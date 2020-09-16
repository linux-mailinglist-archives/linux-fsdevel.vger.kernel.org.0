Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1A126BC6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 08:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIPGPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 02:15:50 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60017 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726093AbgIPGPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:15:49 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 29E185C00F5;
        Wed, 16 Sep 2020 02:15:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 16 Sep 2020 02:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=1FeN9RUCQkpP8rFk9zMjFMsMbdJ
        infBwncvpOPiw/sk=; b=o9xA6zznMel1d8/0CDVc5OYSNmEgxGIpOxDctBhzIWE
        lBXGqJlO8b1ePb9CbhfqZvwesuhmz4963su9cBPKtqYSKvbWKkl2m74i8jF2sjaW
        iPVY8/wr8pe/xjWMTUWMqyhIcJKiXb3qHDd8YewU3hSG71RUewTQwZioXnj2Jqpv
        Y3b9QII/aE65gZCXIkvMKndzPxJmzx+E8tE/zgi6oRpawR40ZpSy7ZkEwhwjzXdH
        oH7ZG2U/LmtOpxcwnX6ZZ23pMQt/LCSa//s49sMfHkxj70m3fCyNmUflSRVrkcAS
        TnuLYa5wfd+6LMybUxyne9/ZoGoVIbKbstmlYH6ssjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=1FeN9R
        UCQkpP8rFk9zMjFMsMbdJinfBwncvpOPiw/sk=; b=WhPubNBp9ZHvAuf7n+yp1o
        M7JxwmAf3ckif65SowVRFr2gAcrF1V3GTmBHllx4mgZi+9WOI1YZPK6L8q09IxnS
        Tuk4AQiR/IQnRb6Y9wrEqqi5M/UnFCxaHNzFTa9lBHfBjZNQ3S3QBJSRqsWpLQoc
        gJyXhndSUBkbTmg7oKdPguP5m7G7gy3wCEJS/weSvcWleaI/5tmzVSoNoqyHFww0
        esyQFoQFGCqYS3eYYAchKgi59Q6DFmMVlenBT212ZqOaFbJZbIhXhpbTubdjze8F
        i+GVWg2FTcCiIYXK6QB2rsTZjNmOqZ1m3WsNOokegaHZKtj66qtzW3dxRL4DU/Ng
        ==
X-ME-Sender: <xms:kq1hX9_aP4uzM24YQiClflVDRYIL03O5WuEawU6tz8lCW8beri0ijA>
    <xme:kq1hXxunXhhMRrDUq-G4I1jmlp5hg2ttllUdhLEGK5ZYC9ScpEDumE37a0IaowurI
    7SuK_pcrJugxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddugdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepjeehheetve
    eiffeutdfhleekkeefleevgfdufeehtdejgeejhfdvffeggfdugeefnecuffhomhgrihhn
    pehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecukfhppeekfedrkeeirdejge
    drieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    ghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:kq1hX7DAs9htEhW1qeGeIoGfJD1BuGigsdJI4ra4Dld1AR1gFKaQjw>
    <xmx:kq1hXxeXykqx3vScv-Sz2tcxcSjsiaSvdw1UtTwEP596EJs77dZrxg>
    <xmx:kq1hXyPDeFPyzTQeVFeU8ogFUoLFswWVd9NWCTMjRk6hyDdgYPOzFw>
    <xmx:k61hX_p3MP55177xEjvwzgNOrliREEKa18IIF4MLhPOCUjX9GzdlYg>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5259E3064684;
        Wed, 16 Sep 2020 02:15:46 -0400 (EDT)
Date:   Wed, 16 Sep 2020 08:16:22 +0200
From:   Greg KH <greg@kroah.com>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH] fs: fix KMSAN uninit-value bug by
 initializing nd in do_file_open_root
Message-ID: <20200916061622.GA142621@kroah.com>
References: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916052657.18683-1-anant.thazhemadam@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:56:56AM +0530, Anant Thazhemadam wrote:
> The KMSAN bug report for the bug indicates that there exists;
> Local variable ----nd@do_file_open_root created at:
>  do_file_open_root+0xa4/0xb40 fs/namei.c:3385
>  do_file_open_root+0xa4/0xb40 fs/namei.c:3385

What does this "error" mean?

> Initializing nd fixes this issue, and doesn't break anything else either
> 
> Fixes: https://syzkaller.appspot.com/bug?extid=4191a44ad556eacc1a7a
> Reported-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
> Tested-by: syzbot+4191a44ad556eacc1a7a@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index e99e2a9da0f7..b27382586209 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3404,7 +3404,7 @@ struct file *do_filp_open(int dfd, struct filename *pathname,
>  struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
>  		const char *name, const struct open_flags *op)
>  {
> -	struct nameidata nd;
> +	struct nameidata nd = {};

What exactly does setting this structure to all 0 fix here that is
currently "broken"?

confused,

greg k-h
