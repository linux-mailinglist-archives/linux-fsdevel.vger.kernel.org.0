Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B6B1418F1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2020 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgARS3R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jan 2020 13:29:17 -0500
Received: from [198.137.202.133] ([198.137.202.133]:43934 "EHLO
        bombadil.infradead.org" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgARS3R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jan 2020 13:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g04JN6Z9CZa797TZy5Lv9GAbaRXGbcffjecnpGZYDOI=; b=S9JncpWzmrbPmUMNCfBYHzjLy
        nMzjqIQWTJ83VZhs37Uu32IC/NA/U1XLsORrwcoi11Qxb2LwTZxO7J3KsQ8MM5Sdv+GRWa4zO+zY2
        KaMtmXRxv0boOpUwh4Uu/e+SKCmGyxJ9j0FGKwiZ3WHNX5kGzKtWCHLz8Nf4pPKEaCSq7pjUw/JPk
        oLLKNJSCdG7w+Ecg4ysn8JReNgorcLdrLbplkNaRC+FcpToPpX0YbT3b4hrdqpIXRUC/rlVG5nzDk
        h9eRlImWYjrLCKT1uFpbUup6UFnI2JpHU8nC4lZZ5/mOvyGEf2yhUiBfdygypgsvCz7osR/Aq+AKD
        UzK9lN5Ng==;
Received: from [2603:3004:32:9a00::ce80]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isspt-0002OA-CD; Sat, 18 Jan 2020 18:28:41 +0000
Subject: Re: [PATCH v6 09/22] Documentation: bootconfig: Add a doc for
 extended boot config
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
 <157867230658.17873.9309879174829924324.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7823298a-88e6-4625-ff10-94b00f7963cb@infradead.org>
Date:   Sat, 18 Jan 2020 10:28:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <157867230658.17873.9309879174829924324.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Editorial comments/corrections below...

On 1/10/20 8:05 AM, Masami Hiramatsu wrote:
> Add a documentation for extended boot config under
> admin-guide, since it is including the syntax of boot config.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Add a note about comment after value.
>  Changes in v5:
>   - Fix to insert bootconfig to TOC list alphabetically.
>   - Add notes about avaliable characters in values.
>   - Fix to use correct quotes (``) for .rst.
>  Changes in v4:
>   - Rename suppremental kernel command line to boot config.

             supplemental

>   - Update document according to the recent changes.
>   - Add How to load it on boot.
>   - Style bugfix.
> ---
>  Documentation/admin-guide/bootconfig.rst |  184 ++++++++++++++++++++++++++++++
>  Documentation/admin-guide/index.rst      |    1 
>  MAINTAINERS                              |    1 
>  3 files changed, 186 insertions(+)
>  create mode 100644 Documentation/admin-guide/bootconfig.rst
> 

> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> new file mode 100644
> index 000000000000..f7475df2a718
> --- /dev/null
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -0,0 +1,184 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
> +Boot Configuration
> +==================
> +
> +:Author: Masami Hiramatsu <mhiramat@kernel.org>
> +
> +Overview
> +========
> +
> +The boot configuration is expanding current kernel cmdline to support

                          expands the current kernel command line to support

> +additional key-value data when boot the kernel in an efficient way.

                                  booting

> +This allows adoministrators to pass a structured-Key config file.

               administrators

> +
> +Config File Syntax
> +==================
> +
> +The boot config syntax is a simple structured key-value. Each key consists
> +of dot-connected-words, and key and value are connected by "=". The value
> +has to be terminated by semi-colon (``;``) or newline (``\n``).
> +For array value, array entries are separated by comma (``,``). ::
> +
> +KEY[.WORD[...]] = VALUE[, VALUE2[...]][;]

(just a note: spaces are OK here, unlike in kernel command line syntax [unless quoted].)

> +
> +Each key word must contain only alphabets, numbers, dash (``-``) or underscore
> +(``_``). And each value only contains printable characters or spaces except
> +for delimiters such as semi-colon (``;``), new-line (``\n``), comma (``,``),
> +hash (``#``) and closing brace (``}``).

what about opening brace '{'?

> +
> +If you want to use those delimiters in a value, you can use either double-
> +quotes (``"VALUE"``) or single-quotes (``'VALUE'``) to quote it. Note that
> +you can not escape these quotes.
> +
> +There can be a key which doesn't have value or has an empty value. Those keys
> +are used for checking the key exists or not (like a boolean).

I would say:    checking if the key exists or not

> +
> +Key-Value Syntax
> +----------------
> +
> +The boot config file syntax allows user to merge partially same word keys
> +by brace. For example::
> +
> + foo.bar.baz = value1
> + foo.bar.qux.quux = value2
> +
> +These can be written also in::
> +
> + foo.bar {
> +    baz = value1
> +    qux.quux = value2
> + }
> +
> +Or more shorter, written as following::
> +
> + foo.bar { baz = value1; qux.quux = value2 }
> +
> +In both styles, same key words are automatically merged when parsing it
> +at boot time. So you can append similar trees or key-values.
> +
> +Comments
> +--------
> +
> +The config syntax accepts shell-script style comments. The comments start

s/start/starting/

> +with hash ("#") until newline ("\n") will be ignored.
> +
> +::
> +
> + # comment line
> + foo = value # value is set to foo.
> + bar = 1, # 1st element
> +       2, # 2nd element
> +       3  # 3rd element
> +
> +This is parsed as below::
> +
> + foo = value
> + bar = 1, 2, 3
> +
> +Note that you can not put a comment between value and delimiter(``,`` or
> +``;``). This means following config has a syntax error ::
> +
> + key = 1 # comment
> +       ,2
> +
> +
> +/proc/bootconfig
> +================
> +
> +/proc/bootconfig is a user-space interface of the boot config.
> +Unlike /proc/cmdline, this file shows the key-value style list.
> +Each key-value pair is shown in each line with following style::
> +
> + KEY[.WORDS...] = "[VALUE]"[,"VALUE2"...]
> +
> +
> +Boot Kernel With a Boot Config
> +==============================
> +
> +Since the boot configuration file is loaded with initrd, it will be added
> +to the end of the initrd (initramfs) image file. The Linux kernel decodes
> +the last part of the initrd image in memory to get the boot configuration
> +data.
> +Because of this "piggyback" method, there is no need to change or
> +update the boot loader and the kernel image itself.
> +
> +To do this operation, Linux kernel provides "bootconfig" command under
> +tools/bootconfig, which allows admin to apply or delete the config file
> +to/from initrd image. You can build it by follwoing command::

                                          by the following

> +
> + # make -C tools/bootconfig
> +
> +To add your boot config file to initrd image, run bootconfig as below
> +(Old data is removed automatically if exists)::
> +
> + # tools/bootconfig/bootconfig -a your-config /boot/initrd.img-X.Y.Z
> +
> +To remove the config from the image, you can use -d option as below::
> +
> + # tools/bootconfig/bootconfig -d /boot/initrd.img-X.Y.Z
> +
> +
> +C onfig File Limitation

   Config

> +======================
> +
> +Currently the maximum config size size is 32KB and the total key-words (not
> +key-value entries) must be under 1024 nodes.
> +Note: this is not the number of entries but nodes, an entry must consume
> +more than 2 nodes (a key-word and a value). So theoretically, it will be
> +up to 512 key-value pairs. If keys contains 3 words in average, it can
> +contain 256 key-value pairs. In most cases, the number of config items
> +will be under 100 entries and smaller than 8KB, so it would be enough.
> +If the node number exceeds 1024, parser returns an error even if the file
> +size is smaller than 32KB.
> +Anyway, since bootconfig command verifies it when appending a boot config
> +to initrd image, user can notice it before boot.
> +
> +
> +Bootconfig APIs
> +===============
> +
> +User can query or loop on key-value pairs, also it is possible to find
> +a root (prefix) key node and find key-values under that node.
> +
> +If you have a key string, you can query the value directly with the key
> +using xbc_find_value(). If you want to know what keys exist in the SKC
> +tree, you can use xbc_for_each_key_value() to iterate key-value pairs.
> +Note that you need to use xbc_array_for_each_value() for accessing
> +each arraies value, e.g.::

        array's
(I think)

> +
> + vnode = NULL;
> + xbc_find_value("key.word", &vnode);
> + if (vnode && xbc_node_is_array(vnode))
> +    xbc_array_for_each_value(vnode, value) {
> +      printk("%s ", value);
> +    }
> +
> +If you want to focus on keys which has a prefix string, you can use

                                      have

> +xbc_find_node() to find a node which prefix key words, and iterate

[confusing above]

> +keys under the prefix node with xbc_node_for_each_key_value().
> +
> +But the most typical usage is to get the named value under prefix
> +or get the named array under prefix as below::
> +
> + root = xbc_find_node("key.prefix");
> + value = xbc_node_find_value(root, "option", &vnode);
> + ...
> + xbc_node_for_each_array_value(root, "array-option", value, anode) {
> +    ...
> + }
> +
> +This accesses a value of "key.prefix.option" and an array of
> +"key.prefix.array-option".
> +
> +Locking is not needed, since after initialized, the config becomes readonly.

                                after initialization,

> +All data and keys must be copied if you need to modify it.
> +
> +
> +Functions and structures
> +========================
> +
> +.. kernel-doc:: include/linux/bootconfig.h
> +.. kernel-doc:: lib/bootconfig.c
> +

HTH.
-- 
~Randy
