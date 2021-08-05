Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C553E1E3B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Aug 2021 23:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhHEV7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Aug 2021 17:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232968AbhHEV7q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Aug 2021 17:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F21AF61157;
        Thu,  5 Aug 2021 21:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628200772;
        bh=MeLnT3CMobnAZ0zp49eYFHn5nhm9lSY2nSjIl9/FEaA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sIJ09dbqA6QWegRxG83cdvb2iyJ5XozAN4pFGeilJSAtq2xF7N4l+BJ5lYvNrj9J+
         +8UO3YH+QcAqRYnR/A6Ybg9g76+Z4zCp/O++V9gsUpHOJ5OgILfFJx08H2sCJbV74N
         7evD+xE5ACYmX7GRUWKEx5/UGG4MGU+hrqET9lHwcfj4TaMdFNY9hEyjyVrf7JHvOx
         YFYmViW1UJVGVmGY95ZvVD2rNLPOSvgK68+Dss8JJJtk2tRaeHEIpqUqDl4IBCmO8o
         f+1T6cF8oNP4fp8HO04e5jZzBeRnp8yqF2GYnbBI5XBes8zxx93EpLRENHEW1PFOCd
         +RjdQHFyi1/uw==
Received: by mail-oo1-f54.google.com with SMTP id o17-20020a4a64110000b0290263e1ba7ff9so1722373ooc.2;
        Thu, 05 Aug 2021 14:59:31 -0700 (PDT)
X-Gm-Message-State: AOAM533dSa8UMPHicpsT9AkrwclIZ17CGaZMaAcvIprldUEiXtY7ygKG
        OUzExqOBOywVKDlH6IFZOTJl/xYF+ZpHo8oQw38=
X-Google-Smtp-Source: ABdhPJwU1DkfO4DN0oavzhohkoWqAhatuJlGM7rEMLHWSs2gBz8qdpYUyQkA591mwk10vKMe5BuouHQYm5Qet9yPaQo=
X-Received: by 2002:a4a:e382:: with SMTP id l2mr4836128oov.85.1628200771299;
 Thu, 05 Aug 2021 14:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7203:0:0:0:0:0 with HTTP; Thu, 5 Aug 2021 14:59:30 -0700 (PDT)
In-Reply-To: <20210805110219.GJ22532@kadam>
References: <20210805060546.3268-1-namjae.jeon@samsung.com>
 <CGME20210805061600epcas1p13ca76c1e21f317f9f3f52860a70a241e@epcas1p1.samsung.com>
 <20210805060546.3268-9-namjae.jeon@samsung.com> <20210805110219.GJ22532@kadam>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 6 Aug 2021 06:59:30 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8y_QPr+9oYqyGGtnunHBXKXi6Qr-YNM=sAsDSvr6r-LQ@mail.gmail.com>
Message-ID: <CAKYAXd8y_QPr+9oYqyGGtnunHBXKXi6Qr-YNM=sAsDSvr6r-LQ@mail.gmail.com>
Subject: Re: [Linux-cifsd-devel] [PATCH v7 08/13] ksmbd: add smb3 engine part 1
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>, linux-cifs@vger.kernel.org,
        aurelien.aptel@gmail.com, linux-cifsd-devel@lists.sourceforge.net,
        sandeen@sandeen.net, linux-kernel@vger.kernel.org,
        willy@infradead.org, hch@infradead.org, senozhatsky@chromium.org,
        viro@zeniv.linux.org.uk, ronniesahlberg@gmail.com,
        linux-fsdevel@vger.kernel.org,
        Steve French <stfrench@microsoft.com>, hch@lst.de,
        christian@brauner.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dan,

2021-08-05 20:02 GMT+09:00, Dan Carpenter <dan.carpenter@oracle.com>:
> On Thu, Aug 05, 2021 at 03:05:41PM +0900, Namjae Jeon wrote:
>> +/**
>> + * check_session_id() - check for valid session id in smb header
>> + * @conn:	connection instance
>> + * @id:		session id from smb header
>> + *
>> + * Return:      1 if valid session id, otherwise 0
>> + */
>> +static inline int check_session_id(struct ksmbd_conn *conn, u64 id)
>
> Make this bool.  Same for all the is_* functions.
Okay, I will fix it on next version.
>
>> +{
>> +	struct ksmbd_session *sess;
>> +
>> +	if (id == 0 || id == -1)
>> +		return 0;
>> +
>> +	sess = ksmbd_session_lookup_all(conn, id);
>> +	if (sess)
>> +		return 1;
>> +	pr_err("Invalid user session id: %llu\n", id);
>> +	return 0;
>> +}
>> +
>> +struct channel *lookup_chann_list(struct ksmbd_session *sess, struct
>> ksmbd_conn *conn)
>> +{
>> +	struct channel *chann;
>> +
>> +	list_for_each_entry(chann, &sess->ksmbd_chann_list, chann_list) {
>> +		if (chann->conn == conn)
>> +			return chann;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * smb2_get_ksmbd_tcon() - get tree connection information for a tree id
>> + * @work:	smb work
>> + *
>> + * Return:      matching tree connection on success, otherwise error
>
> This documentation seems out of date.
Okay.
>
>> + */
>> +int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
>> +{
>> +	struct smb2_hdr *req_hdr = work->request_buf;
>> +	int tree_id;
>> +
>> +	work->tcon = NULL;
>> +	if (work->conn->ops->get_cmd_val(work) == SMB2_TREE_CONNECT_HE ||
>> +	    work->conn->ops->get_cmd_val(work) ==  SMB2_CANCEL_HE ||
>> +	    work->conn->ops->get_cmd_val(work) ==  SMB2_LOGOFF_HE) {
>> +		ksmbd_debug(SMB, "skip to check tree connect request\n");
>> +		return 0;
>> +	}
>> +
>> +	if (xa_empty(&work->sess->tree_conns)) {
>> +		ksmbd_debug(SMB, "NO tree connected\n");
>> +		return -1;
>
> Better to return -EINVAL.
Okay, Will fix it.

Thanks for your review!
>
>> +	}
>> +
>> +	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
>> +	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
>> +	if (!work->tcon) {
>> +		pr_err("Invalid tid %d\n", tree_id);
>> +		return -1;
>> +	}
>> +
>> +	return 1;
>> +}
>
> regards,
> dan carpenter
>
>
> _______________________________________________
> Linux-cifsd-devel mailing list
> Linux-cifsd-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-cifsd-devel
>
