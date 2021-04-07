Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD96356214
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 05:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348405AbhDGDqE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 23:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344405AbhDGDqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 23:46:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD518C06174A;
        Tue,  6 Apr 2021 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9ExJJ7YOeb9duMavNOLOVia4gmkxk4wXEJK45NMP4AU=; b=Aejap9z126V7EqqQKnZIhxwKwX
        VStchJiEAp0EB0hSBN8qqmcYDgB/OILRhEm1A40n9nWm6NDbgMDAFO53yD6sxBaeOYeUrwr7UrakE
        uFINJX5Ac5zoZ+57L42ur9gXYvKs0u7MZq0eCGFWXNZIIMOYjXr19I4rgxUL/TJBtdWDXkwxS1y51
        i7favCC+Bs4MaK8MpSLkZ2i3VyVg8dandFbUlsaOBhMCCww7+7Hyt+fUgnz04agd2csDw59MZCVpN
        82n07kOYR41lHoiqvt7kVwogxX2M3iQm7d81Ohe16CT/yUAgMMGK9l0FTs2ui0U4fc/iPfH+drNM4
        kPZ/UORQ==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lTz81-00DqP3-E5; Wed, 07 Apr 2021 03:45:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] lib: parser: clean up kernel-doc
Date:   Tue,  6 Apr 2021 20:45:14 -0700
Message-Id: <20210407034514.5651-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mark match_uint() as kernel-doc notation since it is already
fully annotated as such.
Use % prefix on constants in kernel-doc comments.
Convert function return descriptions to use the "Return:" kernel-doc
notation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
---
 lib/parser.c |   61 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 23 deletions(-)

--- linux-next-20210406.orig/lib/parser.c
+++ linux-next-20210406/lib/parser.c
@@ -98,7 +98,7 @@ static int match_one(char *s, const char
  * locations.
  *
  * Description: Detects which if any of a set of token strings has been passed
- * to it. Tokens can include up to MAX_OPT_ARGS instances of basic c-style
+ * to it. Tokens can include up to %MAX_OPT_ARGS instances of basic c-style
  * format identifiers which will be taken into account when matching the
  * tokens, and whose locations will be returned in the @args array.
  */
@@ -120,8 +120,10 @@ EXPORT_SYMBOL(match_token);
  * @base: base to use when converting string
  *
  * Description: Given a &substring_t and a base, attempts to parse the substring
- * as a number in that base. On success, sets @result to the integer represented
- * by the string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * as a number in that base.
+ *
+ * Return: On success, sets @result to the integer represented by the
+ * string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 static int match_number(substring_t *s, int *result, int base)
 {
@@ -153,8 +155,10 @@ static int match_number(substring_t *s,
  * @base: base to use when converting string
  *
  * Description: Given a &substring_t and a base, attempts to parse the substring
- * as a number in that base. On success, sets @result to the integer represented
- * by the string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * as a number in that base.
+ *
+ * Return: On success, sets @result to the integer represented by the
+ * string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 static int match_u64int(substring_t *s, u64 *result, int base)
 {
@@ -178,9 +182,10 @@ static int match_u64int(substring_t *s,
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as a decimal integer. On
- * success, sets @result to the integer represented by the string and returns 0.
- * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * Description: Attempts to parse the &substring_t @s as a decimal integer.
+ *
+ * Return: On success, sets @result to the integer represented by the string
+ * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 int match_int(substring_t *s, int *result)
 {
@@ -188,14 +193,15 @@ int match_int(substring_t *s, int *resul
 }
 EXPORT_SYMBOL(match_int);
 
-/*
+/**
  * match_uint - scan a decimal representation of an integer from a substring_t
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as a decimal integer. On
- * success, sets @result to the integer represented by the string and returns 0.
- * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * Description: Attempts to parse the &substring_t @s as a decimal integer.
+ *
+ * Return: On success, sets @result to the integer represented by the string
+ * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 int match_uint(substring_t *s, unsigned int *result)
 {
@@ -217,9 +223,10 @@ EXPORT_SYMBOL(match_uint);
  * @result: resulting unsigned long long on success
  *
  * Description: Attempts to parse the &substring_t @s as a long decimal
- * integer. On success, sets @result to the integer represented by the
- * string and returns 0.
- * Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * integer.
+ *
+ * Return: On success, sets @result to the integer represented by the string
+ * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 int match_u64(substring_t *s, u64 *result)
 {
@@ -232,9 +239,10 @@ EXPORT_SYMBOL(match_u64);
  * @s: substring_t to be scanned
  * @result: resulting integer on success
  *
- * Description: Attempts to parse the &substring_t @s as an octal integer. On
- * success, sets @result to the integer represented by the string and returns
- * 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * Description: Attempts to parse the &substring_t @s as an octal integer.
+ *
+ * Return: On success, sets @result to the integer represented by the string
+ * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 int match_octal(substring_t *s, int *result)
 {
@@ -248,8 +256,9 @@ EXPORT_SYMBOL(match_octal);
  * @result: resulting integer on success
  *
  * Description: Attempts to parse the &substring_t @s as a hexadecimal integer.
- * On success, sets @result to the integer represented by the string and
- * returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ *
+ * Return: On success, sets @result to the integer represented by the string
+ * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
  */
 int match_hex(substring_t *s, int *result)
 {
@@ -263,10 +272,11 @@ EXPORT_SYMBOL(match_hex);
  * @str: the string to be parsed
  *
  * Description: Parse the string @str to check if matches wildcard
- * pattern @pattern. The pattern may contain two type wildcardes:
+ * pattern @pattern. The pattern may contain two types of wildcards:
  *   '*' - matches zero or more characters
  *   '?' - matches one character
- * If it's matched, return true, else return false.
+ *
+ * Return: If the @str matches the @pattern, return true, else return false.
  */
 bool match_wildcard(const char *pattern, const char *str)
 {
@@ -316,7 +326,9 @@ EXPORT_SYMBOL(match_wildcard);
  *
  * Description: Copy the characters in &substring_t @src to the
  * c-style string @dest.  Copy no more than @size - 1 characters, plus
- * the terminating NUL.  Return length of @src.
+ * the terminating NUL.
+ *
+ * Return: length of @src.
  */
 size_t match_strlcpy(char *dest, const substring_t *src, size_t size)
 {
@@ -338,6 +350,9 @@ EXPORT_SYMBOL(match_strlcpy);
  * Description: Allocates and returns a string filled with the contents of
  * the &substring_t @s. The caller is responsible for freeing the returned
  * string with kfree().
+ *
+ * Return: the address of the newly allocated NUL-terminated string or
+ * %NULL on error.
  */
 char *match_strdup(const substring_t *s)
 {
