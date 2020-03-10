Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08517FFD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCJOKP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 10:10:15 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38870 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgCJOKP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 10:10:15 -0400
Received: by mail-il1-f193.google.com with SMTP id f5so12095054ilq.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2020 07:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=IMSgfzJYgymp5J//NAnPuXmv+ttIDEmyfzo3Bl/xD5bXo890r/Y+o2KMqeTHJlcpRr
         LHhWPmBfOOouLuWuT3Uj7HRvFT2ydIXCkZaFwsKzywxSWuEKNBetWQvDVoULEZEDm03p
         tRMUsriMnv8JkVwffZVVKi89BSYtpcGRODjq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Dq64x4DjoKFCRaWP0RmVXxQ/yypMvRHHigI32DgfmA=;
        b=aYLuAIepwr5zguL1F3SUhRd2O4CS8uaWw5jBCy//PX3OJFKVuvMst5TkprAP6AOKS4
         lY3o7dl7VZOBxXmesidAvli+zaSdHsn/TSK3JCk5V+ZxnDIBWSG/A4vRR1NmX139cJ39
         Gb1sAY5xruLJvYe5LGfN2AotYhUfWCtgJeZ55hxRNwFZYdCsmN05lABVJ78X1o5FQ6Y9
         E1YLXpkNl4ctMCDFXJZ9EEZNkAlv6polPq7IWcjg2iXbAX8mVIpfpW1HAfqjC4TdO9V/
         rXi1xKpYnuek6egCaabew6GZ2zel8XB7lbS8Y8aVFJ5StpYzfIO3tI7HrbOpe5yUOqyL
         za4Q==
X-Gm-Message-State: ANhLgQ0t7V49WsWR8MGs3cUAMH89HxMJbzVKaoKHD436QnwE6ge+dv54
        hdVQUFUqCOgIVqO0E61Pi+GcE1IxiaUm4ZWVpwtwjA==
X-Google-Smtp-Source: ADFU+vtA2bBrA3QBgj3ZymF37VCxe3Znyz4vcji09X2nGjZ9/L3vfB4trInJdMsBR57HttHenvzZDwFXg1DyS7Avj/4=
X-Received: by 2002:a92:aa87:: with SMTP id p7mr12249562ill.63.1583849414997;
 Tue, 10 Mar 2020 07:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200304165845.3081-1-vgoyal@redhat.com> <20200304165845.3081-7-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-7-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Mar 2020 15:10:04 +0100
Message-ID: <CAJfpegvKRt6eaZHzs3e70y_c6j5q30jAir6k-hOWevWiQUOVKw@mail.gmail.com>
Subject: Re: [PATCH 06/20] virtiofs: Provide a helper function for virtqueue initialization
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> This reduces code duplication and make it little easier to read code.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
