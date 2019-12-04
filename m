Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722141128C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 11:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLDKCp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 05:02:45 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:45600 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfLDKCp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:02:45 -0500
Received: by mail-wr1-f44.google.com with SMTP id j42so7714228wrj.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 02:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=21jkG+rJD5VlwzL/Z11ofpmFV1k7kp42+v4oB+7OCRQ=;
        b=iJc9JB86jODDi4ujcZo3jJ9NUyupZL8q+5ERLV5hvhdlBMwihDFGQ/DAf9MDPh6lWk
         DwEvcSOSDYs3vUG/zqdNJroC6xI8Kwd35ranYxpKvVGDusyiLAEQ8osdNtJCWxmh2SIW
         xVEySAzLm/5zQbRZUa3k49jSL0TCXjSbyS+1ygZ40ajliPx8ZB52l6ge9G69aW/oFbRQ
         c7Gk85O9E0WO4shIBsNezABKRQ7C3rQZQiqVH6V1QPcUWkruZSk9apsMVSftdpkRuvXh
         /8s8+ypZ2iIqbRAzUXlheWRD9iS9am9jN+RyTL+8yscnLBCuILYzD97cLnhZnJyaYbu8
         3y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=21jkG+rJD5VlwzL/Z11ofpmFV1k7kp42+v4oB+7OCRQ=;
        b=VUFXlM8HiPZyxnyQMWzrnC0EvB2QRSfcPmKHdIHSBAL2S3EIzRgpSVePuPCjI0hGcr
         AmtgjE5BQcZirBa4FHYOW+w8pYrNHZnDaReqKfOcNlScNKbv+DUBTjN3NkKn331XbPkz
         PyYwGprOX/+LmWe925zjcVAXwxPiM+N9SVDgBF5JAUk2tNkoRVKRGMvaiMbT3EfMxtt1
         JkPpEXYF4ZIjJUqcTVfADouz7H/89sNQ7XEwokozW0bA4r3hBP2Mzlqr1cOVrV+ZGZkP
         BRuHUjwQFrTzBHezzaPjKIMhghy340Hss1sW/qkme+8PgpJHqp+2GgeXTSlaKTLvgrk1
         k3tg==
X-Gm-Message-State: APjAAAX6SrAYlHPXMZrwg0HreZsodpRS1NYsZjxqSgHJet14JK0qVQVZ
        uDbIOt6oNgIMRl3rPGWY+b8ut4BQx5nI9VGEj0Jd853nFnU=
X-Google-Smtp-Source: APXvYqwApFkr3eJdIihedDn0tn3myJQOFR/au9Rtf0RHY9/o9vYeDLh2zvdKNAoTFwcm3SpYn5WGprYkYXdk1uht72g=
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr3257231wrq.232.1575453762734;
 Wed, 04 Dec 2019 02:02:42 -0800 (PST)
MIME-Version: 1.0
From:   Mo Re Ra <more7.rev@gmail.com>
Date:   Wed, 4 Dec 2019 13:32:29 +0330
Message-ID: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
Subject: File monitor problem
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I don`t know if this is the correct place to express my issue or not.
I have a big problem. For my project, a Directory Monitor, I`ve
researched about dnotify, inotify and fanotify.
dnotify is the worst choice.
inotify is a good choice but has a problem. It does not work
recursively. When you implement this feature by inotify, you would
miss immediately events after subdir creation.
fanotify is the last choice. It has a big change since Kernel 5.1. But
It does not meet my requirement.

I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
and CLOSE_WRITE events would be happened in its subdirectories.
Filename of the events happened on that (without any miss) is
mandatory for me.

I`ve searched and found a contribution from @amiril73 which
unfortunately has not been merged. Here is the link:
https://github.com/amir73il/fsnotify-utils/issues/1

I`d really appreciate it If you could resolve this issue.

Regards,
Mohammad Reza
